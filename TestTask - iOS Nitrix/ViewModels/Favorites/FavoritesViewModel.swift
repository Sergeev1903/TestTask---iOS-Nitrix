//
//  FavoritesViewModel.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 01.02.2024.
//

import Foundation

protocol FavoritesViewModelProtocol {
  var favoriteItems: [MovieEntity] { get set }
  func numberOfRowsInSection() -> Int
  func cellForRowAt(
    indexPath: IndexPath) -> FavoritesCellViewModelProtocol
  func didSelectRowAt(
    indexPath: IndexPath) -> FavoritesDetailViewModelProtocol
  func fetchAllMoviesFromCoreData(
    completion: @escaping () -> Void)
  func deleteMovieFromCoreData(indexPath: IndexPath)
}

class FavoritesViewModel: FavoritesViewModelProtocol {
  
  // MARK: - Properties
  private let coreDataManager = CoreDataManager.shared
  public var favoriteItems: [MovieEntity] = []
  
  // MARK: - Init
  init() {}
  
  // MARK: - Methods
  public func numberOfRowsInSection() -> Int {
    favoriteItems.count
  }
  
  public func cellForRowAt(
    indexPath: IndexPath) -> FavoritesCellViewModelProtocol {
      let favoriteItem = favoriteItems[indexPath.row]
      return FavoritesCellViewModel(favoriteItem: favoriteItem)
    }
  
  public func didSelectRowAt(
    indexPath: IndexPath) -> FavoritesDetailViewModelProtocol {
      let favoriteItem = favoriteItems[indexPath.row]
      return FavoritesDetailViewModel(favoriteItem: favoriteItem)
    }
  
  // MARK: Persistence
  public func fetchAllMoviesFromCoreData(
    completion: @escaping () -> Void) {
      favoriteItems = coreDataManager.fetchAllMovies()
      completion()
    }
  
  public func deleteMovieFromCoreData(indexPath: IndexPath) {
    let movieToDelete = favoriteItems[indexPath.row]
    coreDataManager.delete(movieEntity: movieToDelete)
    favoriteItems.remove(at: indexPath.row)
  }
}

