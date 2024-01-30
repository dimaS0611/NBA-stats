//
//  PlayersViewModel.swift
//  NBAStats
//
//  Created by Dima Semenovich on 30.01.24.
//

import Foundation
import Combine

final class PlayersViewModel: ObservableObject {

  @Published var searchQuery = ""
  
  @Published var players = [Player]()

  private let networkManager: PlayersNetworkManagerProtocol

  private var nextPage: Int? = 0

  private var allItemsLoaded: Bool = false

  private var cancellables = Set<AnyCancellable>()

  init(networkManager: PlayersNetworkManagerProtocol) {
    self.networkManager = networkManager
    bind()
  }

  func bind() {
    $searchQuery
      .removeDuplicates()
      .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.load(forceReload: true)
      }
      .store(in: &cancellables)
  }

  func load(forceReload: Bool = false) {
    nextPage = forceReload ? 0 : nextPage

    guard let nextPage else { return }

    networkManager.getPlayers(searchQuery: searchQuery, page: nextPage)
      .receive(on: DispatchQueue.main)
      .sink { completion in
        if case let .failure(error) = completion {
          debugPrint(error.localizedDescription)
        }
      } receiveValue: { [weak self] response in
        guard let self else { return }

        if forceReload {
          self.players.removeAll()
        }

        self.players += response.data
        self.nextPage = response.meta.nextPage
      }
      .store(in: &cancellables)
  }
}
