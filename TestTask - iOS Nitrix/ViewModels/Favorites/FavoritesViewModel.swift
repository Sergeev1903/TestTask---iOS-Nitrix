//
//  FavoritesViewModel.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 01.02.2024.
//

import Foundation

protocol FavoritesViewModelProtocol {
  func numberOfRowsInSection() -> Int
  func cellForRowAt(indexPath: IndexPath) -> FavoritesCellViewModelProtocol
  func didSelectItemAt(indexPath: IndexPath) -> MovieDetailViewModelProtocol
  
  // TEST
  func getMovies(completion: @escaping () -> Void)
}

class FavoritesViewModel: FavoritesViewModelProtocol {
  
  // MARK: - Properties
  private let service: MoviesServiceable
  private var favoritesItems: [TMDBMovieResult] = []
  
  // MARK: - Init
  init(service: MoviesServiceable) {
    self.service = service
  }
  
  // MARK: - Methods
  func numberOfRowsInSection() -> Int {
    favoritesItems.count
  }
  
  func cellForRowAt(indexPath: IndexPath) -> FavoritesCellViewModelProtocol {
    let mediaItem = favoritesItems[indexPath.row]
    return FavoritesCellViewModel(mediaItem: mediaItem)
  }
  
  func didSelectItemAt(indexPath: IndexPath) -> MovieDetailViewModelProtocol {
    let mediaItem = favoritesItems[indexPath.item]
    return MovieDetailViewModel(mediaItem: mediaItem)
  }
  
  public func getMovies(completion: @escaping () -> Void) {
    service.getMedia(
      endpoint: MovieEndpoint.trending(page: 1),
      responseModel: TMDBMovieResponse.self) { [weak self] result in
        
        guard let strongSelf = self else { return }
        
        switch result {
        case .success(let response):
          strongSelf.favoritesItems = response.results
        case .failure(let error):
          print(error.message)
        }
        completion()
      }
  }
}

