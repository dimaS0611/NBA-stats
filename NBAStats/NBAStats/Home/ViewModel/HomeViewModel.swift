//
//  HomeViewModel.swift
//  NBAStats
//
//  Created by Dima Semenovich on 29.01.24.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {

  @Published var teams = [Team]()

  private let networkManager: TeamsNetworkManagerProtocol

  private var cancellables = Set<AnyCancellable>()

  init(networkManager: TeamsNetworkManagerProtocol) {
    self.networkManager = networkManager
    load()
  }

  func load() {
    networkManager.getTeams()
      .receive(on: DispatchQueue.main)
      .sink { completion in
        if case let .failure(error) = completion {
          debugPrint(error.localizedDescription)
        }
      } receiveValue: { [weak self] response in
        guard let self else { return }

        self.teams += response.data
      }
      .store(in: &cancellables)
  }
}
