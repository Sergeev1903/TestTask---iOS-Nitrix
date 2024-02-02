//
//  MoviesListCellViewModel.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import Foundation

protocol MoviesListCellViewModelProtocol {
  var movieItemPosterURL: URL? { get }
}

struct MoviesListCellViewModel: MoviesListCellViewModelProtocol {
  
  // MARK: - Properties
  private let movieItem: TMDBMovieResult
  
  var movieItemPosterURL: URL? {
    movieItem.posterURL
  }
  
  // MARK: - Init
  init(movieItem: TMDBMovieResult) {
    self.movieItem = movieItem
  }
  
}
