//
//  MoviesEndpoint.swift
//  WhatToSeeApp
//
//  Created by Артем Сергеев on 16.07.2023.
//

import Foundation

enum MovieCategory: String, CaseIterable {
  case nowPlaying = "Now Playing"
  case trending = "Trending"
}

enum MovieEndpoint {
  case nowPlaying(page: Int)
  case trending(page: Int)
  case movieDetails(id: Int)
}

extension MovieEndpoint: Endpoint {
  
  var path: String {
    
    switch self {
    case .nowPlaying:
      return "/3/movie/now_playing"
    case .trending:
      return "/3/trending/movie/day"
    case .movieDetails(id: let id):
      return "/3/movie/\(id)"
    }
  }
  
  var method: RequestMethod {
    switch self {
    case .nowPlaying, .trending, .movieDetails:
      return .get
    }
  }
  
  var header: [String: String]? {
    switch self {
    case .nowPlaying, .trending, .movieDetails:
      return [
        "Authorization": "Bearer \(accessToken)",
        "Content-Type": "application/json;charset=utf-8"
      ]
    }
  }
  
  var queryItems: [URLQueryItem]? {
    switch self {
    case .nowPlaying(let page), .trending(let page):
      return [URLQueryItem(name: "page", value: "\(page)")]
      
    case .movieDetails:
      return nil
    }
  }
  
  var body: [String : Any]? {
    switch self {
    case .nowPlaying, .trending, .movieDetails:
      return nil
    }
  }
  
}

