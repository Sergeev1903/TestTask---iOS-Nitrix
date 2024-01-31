//
//  MainTabBarController.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    createTabBarItems()
  }
  
  // MARK: - Methods
  private func createTabBarItems() {
    
    let moviesListTabBarItem = createTabBarItem(
      rootController: MoviesListViewController(),
      itemTitle: "Movies List",
      itemImage: "movieclapper")
    
    let favoritesTabBarItems = createTabBarItem(
      rootController: FavoritesViewController(),
      itemTitle: "Favorites",
      itemImage: "heart")
    
    viewControllers = [moviesListTabBarItem, favoritesTabBarItems]
  }
  
}


// MARK: - UITabBarController + Extension
extension UITabBarController {
  
  func createTabBarItem(
    rootController: UIViewController,
    itemTitle: String,
    itemImage: String) -> UIViewController {
      
      let navigationController = UINavigationController(
        rootViewController: rootController)
      
      navigationController.tabBarItem.title = itemTitle
      navigationController.tabBarItem.image = UIImage(systemName: itemImage)
      navigationController.navigationBar.prefersLargeTitles = true
      rootController.navigationItem.title = itemTitle
      
      return navigationController
    }
  
}
