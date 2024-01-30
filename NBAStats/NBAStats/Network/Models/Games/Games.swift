//
//  GamesData.swift
//  NBAStats
//
//  Created by Dima Semenovich on 29.01.24.
//

import Foundation

struct GameData: Decodable {
  let data: [Game]
  let meta: MetaData
}

struct Game: Decodable, Hashable, Equatable, Identifiable {
  let id: Int
  let homeTeam: Team
  let visitorTeam: Team
  let homeTeamScore: Int
  let visitorTeamScore: Int

  enum CodingKeys: String, CodingKey {
    case id
    case homeTeam = "home_team"
    case visitorTeam = "visitor_team"
    case homeTeamScore = "home_team_score"
    case visitorTeamScore = "visitor_team_score"
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.homeTeam = try container.decode(Team.self, forKey: .homeTeam)
    self.visitorTeam = try container.decode(Team.self, forKey: .visitorTeam)
    self.homeTeamScore = try container.decode(Int.self, forKey: .homeTeamScore)
    self.visitorTeamScore = try container.decode(Int.self, forKey: .visitorTeamScore)
  }
}
