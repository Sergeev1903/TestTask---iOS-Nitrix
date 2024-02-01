//
//  FavoritesCellViewModel.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 01.02.2024.
//

import Foundation

protocol FavoritesCellViewModelProtocol {
  var mediaBackdropURL: URL? { get }
  var mediaTitleWithReleaseYear: String { get }
  var mediaTitle: String { get }
  var mediaReleaseYear: String { get }
}

class FavoritesCellViewModel: FavoritesCellViewModelProtocol {
  
  // MARK: - Properties
  private let mediaItem: TMDBMovieResult
  
  var mediaBackdropURL: URL? {
    mediaItem.backdropURL
  }
  
  var mediaTitle: String {
    mediaItem.title ?? ""
  }
  
  var mediaReleaseYear: String {
    let year = mediaItem.releaseDate?.components(separatedBy: "-")
    return year?.first ?? ""
  }
  
  var mediaTitleWithReleaseYear: String {
    mediaTitle + "\n" + mediaReleaseYear
  }
  
  
  // MARK: - Init
  init(mediaItem: TMDBMovieResult) {
    self.mediaItem = mediaItem
  }
}
