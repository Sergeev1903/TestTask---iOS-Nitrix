//
//  FavoritesDetailViewModel.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 01.02.2024.
//

import Foundation

protocol FavoritesDetailViewModelProtocol {
  var favoriteItemBackdropImage: Data? { get }
  var favoriteItemTitleWithReleaseYear: String { get }
  var favoriteItemVoteAverage: String { get }
  var favoriteItemReleaseDate: String { get }
  var favoriteItemOverview: String { get }
  var favoriteItemGenres: String { get }
  func getMovieDetails(completion: @escaping () -> Void)
}


class FavoritesDetailViewModel: FavoritesDetailViewModelProtocol {
  
  // MARK: - Properties
  private let favoriteItem: MovieEntity
  private var genres: [Genre] = []
  private let service: MoviesServiceable
  
  var favoriteItemBackdropImage: Data? {
    favoriteItem.backdropImage
  }
  
  var favoriteItemTitleWithReleaseYear: String {
    guard let year = favoriteItem.releaseDate?.components(separatedBy: "-") else {
      return ""
    }
    return (favoriteItem.tittle ?? "") + " (" + (year.first ?? "") + ")"
  }
  
  var favoriteItemVoteAverage: String {
    favoriteItem.voteAverage == 0 ? "New":
    String(format: "%.1f", favoriteItem.voteAverage)
  }
  
  var favoriteItemReleaseDate: String {
    favoriteItem.releaseDate ?? ""
  }
  
  var favoriteItemOverview: String {
    favoriteItem.overview ?? ""
  }
  
  var favoriteItemGenres: String {
//    favoriteItem.genres ?? ""
  genres.compactMap {$0.name}.lazy.joined(separator: ", ")
  }
  
  // MARK: - Init
  init(favoriteItem: MovieEntity) {
    self.favoriteItem = favoriteItem
    self.service = MoviesService()
  }
  
  // FIXME: -
  // TODO: Figure out how to get genres without an additional request
  // The data must be requested in MoviesListViewModel -> stored with coredata,
  // and fetch in FavoritesViewModel
  public func getMovieDetails(completion: @escaping () -> Void) {
    service.getMedia(
      endpoint: MovieEndpoint.movieDetails(id: Int(favoriteItem.id)),
      responseModel: TMDBMovieResult.self) { [weak self] result in
        
        guard let strongSelf = self else { return }
        
        switch result {
        case .success(let details):
          strongSelf.genres = details.genres ?? []
        case .failure(let error):
          print(error.message)
        }
        completion()
      }
  }
}
