//
//  MoviesListCellViewModel.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import Foundation

protocol MoviesListCellViewModelProtocol {
  var mediaPosterURL: URL? { get }
}

struct MoviesListCellViewModel: MoviesListCellViewModelProtocol {
  
  // MARK: - Properties
  private let mediaItem: TMDBMovieResult
  
  var mediaPosterURL: URL? {
    mediaItem.posterURL
  }
  
  // MARK: - Init
  init(mediaItem: TMDBMovieResult) {
    self.mediaItem = mediaItem
  }
  
}
