//
//  Players.swift
//  NBAStats
//
//  Created by Dima Semenovich on 30.01.24.
//

import Foundation

struct PlayersData: Decodable {
  let data: [Player]
  let meta: MetaData
}

struct Player: Decodable, Hashable, Equatable, Identifiable {
  let id: Int
  let firstName: String
  let lastName: String
  let team: Team

  enum CodingKeys: String, CodingKey {
    case id
    case firstName = "first_name"
    case lastName = "last_name"
    case team
  }
}
