//
//  Team.swift
//  NBAStats
//
//  Created by Dima Semenovich on 29.01.24.
//

import Foundation

struct TeamsData: Decodable {
  let data: [Team]
  let meta: MetaData
}

struct Team: Decodable, Hashable, Equatable, Identifiable {
  let id: Int
  let abbreviation: String
  let city: String
  let conference: String
  let division: String
  let fullName: String
  let name: String

  enum CodingKeys: String, CodingKey {
    case id
    case abbreviation
    case city
    case conference
    case division
    case fullName = "full_name"
    case name
  }
}
