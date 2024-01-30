//
//  NetworkManager.swift
//  NBAStats
//
//  Created by Dima Semenovich on 29.01.24.
//

import Foundation
import Combine
import Alamofire

class NetworkManager {
  func request<DecodeType: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<DecodeType, AFError> {
    let headers: HTTPHeaders = ["Accept": "application/json"]

    return AF.request(endpoint.url, method: endpoint.method, headers: headers)
      .validate()
      .publishDecodable(type: DecodeType.self)
      .value()
  }
}
