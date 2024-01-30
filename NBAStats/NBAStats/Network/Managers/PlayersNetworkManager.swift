//
//  PlayersNetworkManager.swift
//  NBAStats
//
//  Created by Dima Semenovich on 30.01.24.
//

import Foundation
import Combine
import Alamofire

protocol PlayersNetworkManagerProtocol {
  func getPlayers(searchQuery: String, page: Int) -> AnyPublisher<PlayersData, AFError>
}

final class PlayersNetworkManager: NetworkManager, PlayersNetworkManagerProtocol {
  func getPlayers(searchQuery: String = "", page: Int = 0) -> AnyPublisher<PlayersData, AFError> {
    request(.players(playerName: searchQuery, page: page))
  }
}
