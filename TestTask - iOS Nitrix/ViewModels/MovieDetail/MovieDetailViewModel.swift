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
  var detailGenres: String { get }
  func getMovieDetails(completion: @escaping () -> Void)
}

class MovieDetailViewModel: MovieDetailViewModelProtocol {
  
  // MARK: - Properties
  private let mediaItem: TMDBMovieResult
  private var mediaGenres: [Genre] = []
  private let service: MoviesServiceable
  
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
  
  var detailGenres: String {
  mediaGenres.compactMap {$0.name}.lazy.joined(separator: ", ")
  }
  
  // MARK: - Init
  init(mediaItem: TMDBMovieResult) {
    self.mediaItem = mediaItem
    self.service = MoviesService()
  }
  
  public func getMovieDetails(completion: @escaping () -> Void) {
    service.getMedia(
      endpoint: MovieEndpoint.movieDetails(id: mediaItem.id!),
      responseModel: TMDBMovieResult.self) { [weak self] result in
        
        guard let strongSelf = self else { return }
        
        switch result {
        case .success(let details):
          strongSelf.mediaGenres = details.genres ?? []
        case .failure(let error):
          print(error.message)
        }
        completion()
      }
  }
  
}



