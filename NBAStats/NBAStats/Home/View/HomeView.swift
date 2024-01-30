//
//  HomeView.swift
//  NBAStats
//
//  Created by Dima Semenovich on 29.01.24.
//

import SwiftUI

struct HomeView: View {
  @StateObject private var viewModel: HomeViewModel

  init(viewModel: HomeViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }

  var body: some View {
    NavigationStack {
      StatsTable(data: $viewModel.teams,
                 headers: ["Name", "City", "Conference"]) { team in
        teamView(team)
      }
      .navigationTitle("Home")
      .navigationDestination(for: Team.self) { team in
        let networkManager = TeamsNetworkManager()
        let viewModel = TeamGamesViewModel(team: team,
                                           networkManager: networkManager)
        TeamGamesView(viewModel: viewModel)
      }
    }
  }

  func teamView(_ team: Team) -> some View {
    VStack {
      NavigationLink(value: team) {
        Text(team.fullName)
          .frame(maxWidth: UIScreen.main.bounds.width / 3)

        Text(team.city)
          .frame(maxWidth: UIScreen.main.bounds.width / 3)

        Text(team.conference)
          .frame(maxWidth: UIScreen.main.bounds.width / 3)
      }

      Divider()
    }
    .padding(.vertical, 8)
    .tint(.primary)
  }
}

#Preview {
  HomeView(viewModel: HomeViewModel(networkManager: TeamsNetworkManager()))
}
