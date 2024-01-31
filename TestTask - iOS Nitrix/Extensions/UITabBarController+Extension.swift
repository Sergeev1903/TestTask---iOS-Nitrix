//
//  UITabBar+Extension.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import UIKit

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
