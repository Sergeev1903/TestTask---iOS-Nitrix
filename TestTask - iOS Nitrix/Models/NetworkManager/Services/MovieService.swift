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
  func downloadImage(
    from url: URL, completion: @escaping (Data?) -> Void)
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
  
  // FIXME: -
  func downloadImage(from url: URL, completion: @escaping (Data?) -> Void) {
      URLSession.shared.dataTask(with: url) { data, response, error in
          guard let data = data, error == nil else {
              print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
              completion(nil)
              return
          }
          completion(data)
      }.resume()
  }
  // FIXME: -
  
}
