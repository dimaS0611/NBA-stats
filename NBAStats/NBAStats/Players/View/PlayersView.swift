//
//  PlayersView.swift
//  NBAStats
//
//  Created by Dima Semenovich on 30.01.24.
//

import SwiftUI

struct PlayersView: View {

  @StateObject private var viewModel: PlayersViewModel

  init(viewModel: PlayersViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }

  var body: some View {
    NavigationStack {
      StatsTable(data: $viewModel.players,
                 headers: [String(localized: "First Name", table: "Localizable"),
                           String(localized: "Last Name", table: "Localizable"),
                           String(localized: "Team", table: "Localizable")], { player in
        playerView(player)
      }, loadMore: {
        viewModel.load()
      })
      .navigationTitle("Players")
      .searchable(text: $viewModel.searchQuery)
      .navigationDestination(for: Team.self) { team in
        let networkManager = TeamsNetworkManager()
        let viewModel = TeamGamesViewModel(team: team,
                                           networkManager: networkManager)
        TeamGamesView(viewModel: viewModel)
      }
    }
  }

  func playerView(_ player: Player) -> some View {
    VStack {
      NavigationLink(value: player.team) {
        Text(player.firstName)
          .frame(maxWidth: UIScreen.main.bounds.width / 3)

        Text(player.lastName)
          .frame(maxWidth: UIScreen.main.bounds.width / 3)

        Text(player.team.fullName)
          .frame(maxWidth: UIScreen.main.bounds.width / 3)
      }

      Divider()
    }
    .padding(.vertical, 8)
    .tint(.primary)
  }
}
