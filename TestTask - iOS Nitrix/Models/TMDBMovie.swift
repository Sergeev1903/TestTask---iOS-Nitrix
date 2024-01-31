//
//  TMDBMovie.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//


import Foundation

// MARK: - TMDBMovieResponse
struct TMDBMovieResponse: Codable {
  let results: [TMDBMovieResult]
  let totalResults: Int
  let page: Int
  let totalPages: Int
}

// MARK: - TMDBMovieResult
struct TMDBMovieResult: Codable {
  let id: Int?
  let title: String?
  let originalTitle: String?
  let posterPath: String?
  let backdropPath: String?
  let releaseDate: String?
  let voteAverage: Double?
  let overview: String?
  
  var posterURL: URL? {
    return URL(
      string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
  }
  
  var backdropURL: URL? {
    return URL(
      string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")
  }
  
}
