//
//  MovieService.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import Foundation

protocol MoviesServiceable {
  func getMedia<T: Codable>(
    endpoint: Endpoint, responseModel: T.Type,
    completion: @escaping (Result<T, RequestError>) -> Void)
}

struct MoviesService: HTTPClient, MoviesServiceable {
  
  func getMedia<T>(endpoint: Endpoint,
                   responseModel: T.Type,
                   completion: @escaping (Result<T, RequestError>) -> Void)
  where T : Decodable, T : Encodable {
    
    DispatchQueue.global(qos: .userInitiated ).async {
      sendRequest(endpoint: endpoint,
                  responseModel: responseModel.self) { result in
        DispatchQueue.main.async {
          completion(result)
        }
      }
    }
  }
  
}
