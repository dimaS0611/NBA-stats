//
//  TeamGamesView.swift
//  NBAStats
//
//  Created by Dima Semenovich on 29.01.24.
//

import SwiftUI

struct TeamGamesView: View {
  @StateObject private var viewModel: TeamGamesViewModel

  init(viewModel: TeamGamesViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    StatsTable(data: $viewModel.games,
               headers: ["Home\nName",
                         "Home\nScore",
                         "Visitor\nName",
                         "Visitor\nScore"], { game in
      gameView(game)
    }, loadMore: viewModel.load)
    .navigationTitle(viewModel.team.fullName)
    .navigationBarTitleDisplayMode(.inline)
  }

  func gameView(_ game: Game) -> some View {
    VStack {
      HStack {
        Text(game.homeTeam.fullName)
          .frame(maxWidth: UIScreen.main.bounds.width / 4)

        Text("\(game.homeTeamScore)")
          .frame(maxWidth: UIScreen.main.bounds.width / 4)

        Text(game.visitorTeam.fullName)
          .frame(maxWidth: UIScreen.main.bounds.width / 4)

        Text("\(game.visitorTeamScore)")
          .frame(maxWidth: UIScreen.main.bounds.width / 4)
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
