//
//  TeamsNetworkManager.swift
//  NBAStats
//
//  Created by Dima Semenovich on 29.01.24.
//

import Foundation
import Combine
import Alamofire

protocol TeamsNetworkManagerProtocol {
  func getTeams() -> AnyPublisher<TeamsData, AFError>
  func getTeamGames(id: Int, page: Int) -> AnyPublisher<GameData, AFError>
}

final class TeamsNetworkManager: NetworkManager, TeamsNetworkManagerProtocol {
  func getTeamGames(id: Int, page: Int) -> AnyPublisher<GameData, AFError> {
    request(.teamGames(id: id, page: page))
  }
  
  func getTeams() -> AnyPublisher<TeamsData, AFError> {
    request(.teams)
  }
}
