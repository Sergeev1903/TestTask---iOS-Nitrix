//
//  MovieDetailViewModel.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import Foundation

protocol MovieDetailViewModelProtocol {
  var mediaBackdropURL: URL? { get }
  var mediaTitleWithReleaseYear: String { get }
  var mediaVoteAverage: String { get }
  var mediaReleaseDate: String { get }
  var mediaOverview: String { get }
}

class MovieDetailViewModel: MovieDetailViewModelProtocol {
  
  // MARK: - Properties
  private let mediaItem: TMDBMovieResult
  
  var mediaBackdropURL: URL? {
    mediaItem.backdropURL
  }
  
  var mediaTitleWithReleaseYear: String {
    guard let year = mediaItem.releaseDate?.components(separatedBy: "-") else {
      return ""
    }
    return (mediaItem.title ?? "") + " (" + (year.first ?? "") + ")"
  }
  
  var mediaVoteAverage: String {
    mediaItem.voteAverage == 0 ? "New":
    String(format: "%.1f", mediaItem.voteAverage!)
  }
  
  var mediaReleaseDate: String {
    mediaItem.releaseDate ?? ""
  }
  
  var mediaOverview: String {
    mediaItem.overview ?? ""
  }
  
  // MARK: - Init
  init(mediaItem: TMDBMovieResult) {
    self.mediaItem = mediaItem
  }
  
}



