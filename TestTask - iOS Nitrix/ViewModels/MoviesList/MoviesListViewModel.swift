//
//  MoviesListViewModel.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import Foundation

protocol MoviesListViewModelProtocol {
  var nowPlayingMovies: [TMDBMovieResult] { get }
  func getMovies(completion: @escaping () -> Void)
  func numberOfItemsInSection() -> Int
  func cellForItemAt(indexPath: IndexPath) -> MoviesListCellViewModelProtocol
  func didSelectItemAt(indexPath: IndexPath) -> MovieDetailViewModelProtocol
}


class MoviesListViewModel: MoviesListViewModelProtocol {
  
  // MARK: - Properties
  public var nowPlayingMovies: [TMDBMovieResult] = []
  private let service: MoviesServiceable
  
  // MARK: - Init
  init(service: MoviesServiceable) {
    self.service = service
  }
  
  // MARK: - Methods
  public func numberOfItemsInSection() -> Int {
    nowPlayingMovies.count
  }
  
  public func cellForItemAt(indexPath: IndexPath) -> MoviesListCellViewModelProtocol {
    let item = nowPlayingMovies[indexPath.item]
    return MoviesListCellViewModel(mediaItem: item)
  }
  
  public func didSelectItemAt(indexPath: IndexPath) -> MovieDetailViewModelProtocol {
    let mediaItem = nowPlayingMovies[indexPath.item]
    return MovieDetailViewModel(mediaItem: mediaItem)
  }
  
  public func getMovies(completion: @escaping () -> Void) {
    service.getMedia(
      endpoint: MovieEndpoint.nowPlaying(page: 1),
      responseModel: TMDBMovieResponse.self) { [weak self] result in
        
        guard let strongSelf = self else { return }
        
        switch result {
        case .success(let response):
          strongSelf.nowPlayingMovies = response.results
        case .failure(let error):
          print(error.message)
        }
        completion()
      }
  }
  
}


