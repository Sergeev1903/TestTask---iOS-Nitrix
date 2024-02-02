//
//  MainTabBarController.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  // MARK: - Properties
  private let service = MoviesService()
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    createTabBarItems()
  }
  
  // MARK: - Methods
  private func createTabBarItems() {
    
    // MARK: Movies List
  guard let moviesListViewController = UIStoryboard(
      name: "Main",
      bundle: nil)
    .instantiateViewController(
      identifier: "MoviesListViewController") as? MoviesListViewController else {
    return
  }
    moviesListViewController.viewModel = MoviesListViewModel(service: service)
    
    let moviesListTabBarItem = createTabBarItem(
      rootController: moviesListViewController,
      itemTitle: "Movies List",
      itemImage: "movieclapper")
    
    // MARK: Favorites
    let favoritesViewController = FavoritesViewController(FavoritesViewModel())
    
    let favoritesTabBarItems = createTabBarItem(
      rootController: favoritesViewController,
      itemTitle: "Favorites",
      itemImage: "heart")
    
    viewControllers = [moviesListTabBarItem, favoritesTabBarItems ]
  }
  
}
