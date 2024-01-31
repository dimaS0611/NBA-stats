//
//  HomeViewModel.swift
//  NBAStats
//
//  Created by Dima Semenovich on 29.01.24.
//

import Foundation
import Combine

extension HomeViewModel {
  enum SortOrder: CaseIterable {
    case name
    case city
    case conference

    var title: String {
      switch self {
      case .name:
        return String(localized: "Name", table: "Localizable")
      case .city:
        return String(localized: "City", table: "Localizable")
      case .conference:
        return String(localized: "Conference", table: "Localizable")
      }
    }
  }
}

final class HomeViewModel: ObservableObject {

  @Published var teams = [Team]()

  @Published var sortOrder: SortOrder = .name

  private let networkManager: TeamsNetworkManagerProtocol

  private var cancellables = Set<AnyCancellable>()

  init(networkManager: TeamsNetworkManagerProtocol) {
    self.networkManager = networkManager
    load()
    bind()
  }
  
  private func bind() {
    $sortOrder
      .removeDuplicates()
      .sink { [weak self] order in
        self?.sortTeams(by: order)
      }
      .store(in: &cancellables)
  }

  private func sortTeams(by order: HomeViewModel.SortOrder) {
    switch order {
    case .name:
      teams = teams.sorted(by: { $0.fullName < $1.fullName })
    case .city:
      teams = teams.sorted(by: { $0.city < $1.city })
    case .conference:
      teams = teams.sorted(by: { $0.conference < $1.conference })
    }
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
