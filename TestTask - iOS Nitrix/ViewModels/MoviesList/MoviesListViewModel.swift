//
//  MoviesListViewModel.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import Foundation

protocol MoviesListViewModelProtocol {
  var movieItems: [TMDBMovieResult] { get }
  func getMovies(completion: @escaping () -> Void)
  func numberOfItemsInSection() -> Int
  func cellForItemAt(
    indexPath: IndexPath) -> MoviesListCellViewModelProtocol
  func didSelectItemAt(
    indexPath: IndexPath) -> MovieListDetailViewModelProtocol
  func saveMovieToCoreData(indexPath: IndexPath)
}

class MoviesListViewModel: MoviesListViewModelProtocol {
  
  // MARK: - Properties
  private let service: MoviesServiceable
  private let coreDataManager = CoreDataManager.shared
  public var movieItems: [TMDBMovieResult] = []
  
  // MARK: - Init
  init(service: MoviesServiceable) {
    self.service = service
  }
  
  // MARK: - Methods
  public func numberOfItemsInSection() -> Int {
    movieItems.count
  }
  
  public func cellForItemAt(
    indexPath: IndexPath) -> MoviesListCellViewModelProtocol {
      let movieItem = movieItems[indexPath.item]
      return MoviesListCellViewModel(movieItem: movieItem)
    }
  
  public func didSelectItemAt(
    indexPath: IndexPath) -> MovieListDetailViewModelProtocol {
      let movieItem = movieItems[indexPath.item]
      return MovieListDetailViewModel(movieItem: movieItem)
    }
  
  // MARK: Networking
  public func getMovies(completion: @escaping () -> Void) {
    service.getMedia(
      endpoint: MovieEndpoint.nowPlaying(page: 1),
      responseModel: TMDBMovieResponse.self) { [weak self] result in
        
        guard let strongSelf = self else { return }
        
        switch result {
        case .success(let response):
          strongSelf.movieItems = response.results
        case .failure(let error):
          print(error.message)
        }
        completion()
      }
  }
  
  // MARK: Persistence
  public func saveMovieToCoreData(indexPath: IndexPath) {
    let movie = movieItems[indexPath.item]
    
    let movieEntity = coreDataManager.createMovieEntity()
    movieEntity.id = Int32(movie.id ?? 0)
    movieEntity.tittle = movie.title
    movieEntity.originalTitle = movie.originalTitle
    movieEntity.releaseDate = movie.releaseDate
    movieEntity.voteAverage = movie.voteAverage ?? 0
    movieEntity.overview = movie.overview
    
    if let posterURL = movie.posterURL {
      service.downloadImage(from: posterURL) { data in
        if let imageData = data {
          movieEntity.posterImage = imageData
          self.coreDataManager.saveContext()
        }
      }
    }
    
    if let backdropURL = movie.backdropURL {
      service.downloadImage(from: backdropURL) { data in
        if let imageData = data {
          movieEntity.backdropImage = imageData
          self.coreDataManager.saveContext()
        }
      }
    }
    
    if let genres = movie.genres {
      movieEntity.genres = genres.map { $0.name }.joined(separator: ", ")
    }
  }
  
}


