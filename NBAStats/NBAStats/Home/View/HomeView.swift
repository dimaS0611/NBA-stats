//
//  HomeView.swift
//  NBAStats
//
//  Created by Dima Semenovich on 29.01.24.
//

import SwiftUI

struct HomeView: View {
  @StateObject private var viewModel: HomeViewModel

  @State private var showSortSheet: Bool = false

  init(viewModel: HomeViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }

  var body: some View {
    NavigationStack {
      StatsTable(data: $viewModel.teams,
                 headers: [String(localized: "Name", table: "Localizable"),
                           String(localized: "City", table: "Localizable"),
                           String(localized: "Conference", table: "Localizable")]) { team in
        teamView(team)
      }
      .navigationTitle("Home")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button(action: {
            showSortSheet = true
          }, label: {
            Text(viewModel.sortOrder.title)
              .foregroundStyle(Color.primary)
              .padding(.horizontal)
              .padding(.vertical, 8)
              .background(.gray.opacity(0.5))
              .clipShape(Capsule())
          })
        }
      }
      .sheet(isPresented: $showSortSheet) {
        sortSheet
          .presentationDetents([.height(200)])
      }
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

  var sortSheet: some View {
    VStack {
      Rectangle()
        .foregroundStyle(.gray)
        .frame(width: 50, height: 5)
        .clipShape(Capsule())
        .padding()

      Spacer()

      ForEach(HomeViewModel.SortOrder.allCases, id: \.title) { option in
        VStack(alignment: .leading) {
          Button(action: {
            viewModel.sortOrder = option
            showSortSheet = false
          }, label: {
            HStack {
              Text(option.title)
                .font(.title2)
                .foregroundStyle(Color.primary)
                .padding(.horizontal)

              Spacer()
            }
          })

          Divider()
        }
      }
    }
  }
}

#Preview {
  HomeView(viewModel: HomeViewModel(networkManager: TeamsNetworkManager()))
}
