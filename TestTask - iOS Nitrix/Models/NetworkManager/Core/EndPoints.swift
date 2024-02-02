//
//  EndPoints.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import Foundation

protocol Endpoint {
  var apiKey: String { get }
  var accessToken: String { get }
  var accountID: String { get }
  var scheme: String { get }
  var host: String { get }
  var path: String { get }
  var method: RequestMethod { get }
  var header: [String: String]? { get }
  var body: [String: Any]? { get }
  var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
  
  var apiKey: String {
    return "2ccc9fcb3e886fcb5f80015418735095"
  }
  
  var accessToken: String {
    return "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyY2NjOWZjYjNlODg2ZmNiNWY4MDAxNTQxODczNTA 5NSIsInN1YiI6IjY1Yjc0MTJiYTBiNjkwMDE3YmNlZjhmOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJ dLCJ2ZXJzaW9uIjoxfQ.Hhl93oP6hoKiYuXMis5VT-MVRfv1KZXhJjSncyCkhpw"
  }
  
  var accountID: String {
    return "18078644"
  }
  
  var scheme: String {
    return "https"
  }
  
  var host: String {
    return "api.themoviedb.org"
  }
  
}
