//
//  FavoritesCellViewModel.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 01.02.2024.
//

import Foundation

protocol FavoritesCellViewModelProtocol {
  var favoriteItemBackdropImage: Data? { get }
  var favoriteItemTitleWithReleaseYear: String { get }
  var favoriteItemTitle: String { get }
  var favoriteItemReleaseYear: String { get }
}


class FavoritesCellViewModel: FavoritesCellViewModelProtocol {
  
  // MARK: - Properties
  private let favoriteItem: MovieEntity
  
  var favoriteItemBackdropImage: Data? {
    favoriteItem.backdropImage
  }
  
  var favoriteItemTitle: String {
    favoriteItem.tittle ?? ""
  }
  
  var favoriteItemReleaseYear: String {
    let year = favoriteItem.releaseDate?.components(separatedBy: "-")
    return year?.first ?? ""
  }
  
  var favoriteItemTitleWithReleaseYear: String {
    favoriteItemTitle + "\n" + favoriteItemReleaseYear
  }
  
  // MARK: - Init
  init(favoriteItem: MovieEntity) {
    self.favoriteItem = favoriteItem
  }
}
