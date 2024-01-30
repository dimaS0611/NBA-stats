//
//  Endpoint.swift
//  NBAStats
//
//  Created by Dima Semenovich on 29.01.24.
//

import Foundation
import Alamofire

enum Endpoint {
  case teams
  case teamGames(id: Int, page: Int)
  case players(playerName: String, page: Int)

  var url: String {
    switch self {
    case .teams:
      return "https://www.balldontlie.io/api/v1/teams"
    case .teamGames(let id, let page):
      return "https://www.balldontlie.io/api/v1/games?&team_ids[]=\(id)&page=\(page)"
    case .players(let playerName, let page):
      return "https://www.balldontlie.io/api/v1/players?search=\(playerName)&page=\(page)"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .teams:
      return .get
    case .teamGames:
      return .get
    case .players:
      return .get
    }
  }
}
