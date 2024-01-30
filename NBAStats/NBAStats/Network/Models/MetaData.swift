//
//  MetaData.swift
//  NBAStats
//
//  Created by Dima Semenovich on 29.01.24.
//

import Foundation

struct MetaData: Decodable {
  let currentPage: Int
  let nextPage: Int?

  enum CodingKeys: String, CodingKey {
    case currentPage = "current_page"
    case nextPage = "next_page"
  }
}
