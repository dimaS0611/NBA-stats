//
//  TeamGamesViewModel.swift
//  NBAStats
//
//  Created by Dima Semenovich on 29.01.24.
//

import Foundation
import Combine

final class TeamGamesViewModel: ObservableObject {
  @Published var games = [Game]()

  let team: Team

  private let networkManager: TeamsNetworkManagerProtocol

  private var nextPage: Int? = 0

  private var allItemsLoaded: Bool = false

  private var cancellables = Set<AnyCancellable>()

  init(team: Team, networkManager: TeamsNetworkManagerProtocol) {
    self.team = team
    self.networkManager = networkManager
    load()
  }

  func load() {
    guard !allItemsLoaded,
          let nextPage else {
      return
    }

    networkManager.getTeamGames(id: team.id, page: nextPage)
      .receive(on: DispatchQueue.main)
      .sink { completion in
        if case let .failure(error) = completion {
          debugPrint(error.localizedDescription)
        }
      } receiveValue: { [weak self] response in
        guard let self else { return }

        self.games += response.data
        self.nextPage = response.meta.nextPage

        self.allItemsLoaded = response.meta.nextPage == nil
      }
      .store(in: &cancellables)
  }
}
