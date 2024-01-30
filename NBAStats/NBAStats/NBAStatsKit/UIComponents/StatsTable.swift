//
//  StatsTable.swift
//  NBAStats
//
//  Created by Dima Semenovich on 30.01.24.
//

import SwiftUI

struct StatsTable<RowContent: View, Data: Identifiable>: View {

  @Binding private var data: [Data]
  let headers: [String]
  let rowView: (Data) -> RowContent
  let loadMore: (() -> Void)?

  init(data: Binding<[Data]>,
       headers: [String],
       _ rowView: @escaping (Data) -> RowContent,
       loadMore: (() -> Void)? = nil) {
    self._data = data
    self.headers = headers
    self.rowView = rowView
    self.loadMore = loadMore
  }

  var body: some View {
    VStack {
      headerView

      ScrollView {
        LazyVStack {
          ForEach(Array(data.enumerated()), id: \.element.id) { (idx, datum) in
            rowView(datum)
              .onAppear {
                if idx == data.count - 1 {
                  loadMore?()
                }
              }
          }
        }
      }
      .scrollIndicators(.hidden)
      .padding(.horizontal)
    }
  }

  var headerView: some View {
    VStack(spacing: 0) {
      HStack {
        ForEach(headers, id: \.self) { header in
          Text(header)
            .frame(maxWidth: UIScreen.main.bounds.width / CGFloat(headers.count))
        }
      }

      Divider()
        .padding(.top)
    }
    .bold()
  }
}
