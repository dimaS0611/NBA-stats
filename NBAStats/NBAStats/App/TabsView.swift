//
//  TabsView.swift
//  NBAStats
//
//  Created by Dima Semenovich on 30.01.24.
//

import SwiftUI

struct TabsView: View {
  var body: some View {
    TabView {
      homeView
        .tabItem { 
          Label("Home", systemImage: "house")
        }

      playersView
        .tabItem {
          Label("Players", systemImage: "figure.run")
        }
    }
  }

  @ViewBuilder
  var homeView: some View {
    let networkManager = TeamsNetworkManager()
    let viewModel = HomeViewModel(networkManager: networkManager)
    HomeView(viewModel: viewModel)
  }

  @ViewBuilder
  var playersView: some View {
    let networkManager = PlayersNetworkManager()
    let viewModel = PlayersViewModel(networkManager: networkManager)
    PlayersView(viewModel: viewModel)
  }
}

#Preview {
  TabsView()
}
