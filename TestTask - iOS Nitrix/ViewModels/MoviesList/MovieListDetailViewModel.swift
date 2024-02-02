//
//  MovieDetailViewModel.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import Foundation

protocol MovieListDetailViewModelProtocol {
  var movieItemBackdropURL: URL? { get }
  var movieItemTitleWithReleaseYear: String { get }
  var movieItemVoteAverage: String { get }
  var movieItemReleaseDate: String { get }
  var movieItemOverview: String { get }
  var movieItemGenres: String { get }
  func getMovieDetails(completion: @escaping () -> Void)
}

class MovieListDetailViewModel: MovieListDetailViewModelProtocol {
  
  // MARK: - Properties
  private let movieItem: TMDBMovieResult
  private var movieGenres: [Genre] = []
  private let service: MoviesServiceable
  
  var movieItemBackdropURL: URL? {
    movieItem.backdropURL
  }
  
  var movieItemTitleWithReleaseYear: String {
    guard let year = movieItem.releaseDate?.components(separatedBy: "-") else {
      return ""
    }
    return (movieItem.title ?? "") + " (" + (year.first ?? "") + ")"
  }
  
  var movieItemVoteAverage: String {
    movieItem.voteAverage == 0 ? "New":
    String(format: "%.1f", movieItem.voteAverage!)
  }
  
  var movieItemReleaseDate: String {
    movieItem.releaseDate ?? ""
  }
  
  var movieItemOverview: String {
    movieItem.overview ?? ""
  }
  
  var movieItemGenres: String {
    movieGenres.compactMap {$0.name}.lazy.joined(separator: ", ")
  }
  
  // MARK: - Init
  init(movieItem: TMDBMovieResult) {
    self.movieItem = movieItem
    self.service = MoviesService()
  }
  
  // FIXME: -
  public func getMovieDetails(completion: @escaping () -> Void) {
    service.getMedia(
      endpoint: MovieEndpoint.movieDetails(id: movieItem.id!),
      responseModel: TMDBMovieResult.self) { [weak self] result in
        
        guard let strongSelf = self else { return }
        
        switch result {
        case .success(let details):
          strongSelf.movieGenres = details.genres ?? []
        case .failure(let error):
          print(error.message)
        }
        completion()
      }
  }
  
}



