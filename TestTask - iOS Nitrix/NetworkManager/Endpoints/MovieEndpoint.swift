//
//  MoviesEndpoint.swift
//  WhatToSeeApp
//
//  Created by Артем Сергеев on 16.07.2023.
//

import Foundation

enum MovieCategory: String, CaseIterable {
  case nowPlaying = "Now Playing"
}

enum MovieEndpoint {
  case nowPlaying(page: Int)
}

extension MovieEndpoint: Endpoint {
  
  var path: String {
    
    switch self {
    case .nowPlaying:
      return "/3/movie/now_playing"
    }
  }
  
  var method: RequestMethod {
    switch self {
    case .nowPlaying:
      return .get
    }
  }
  
  var header: [String: String]? {
    switch self {
    case .nowPlaying:
      return [
        "Authorization": "Bearer \(accessToken)",
        "Content-Type": "application/json;charset=utf-8"
      ]
    }
  }
  
  var queryItems: [URLQueryItem]? {
    switch self {
    case .nowPlaying(let page):
      return [URLQueryItem(name: "page", value: "\(page)")]
    }
  }
  
  var body: [String : Any]? {
    switch self {
    case .nowPlaying:
      return nil
    }
  }
  
}

