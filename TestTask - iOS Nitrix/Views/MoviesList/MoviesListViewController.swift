//
//  ViewController.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import UIKit

class MoviesListViewController: UIViewController {
  
  //MARK: - Outlets
  
  @IBOutlet weak var collectionView: UICollectionView!

  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
  }
  
  
  // MARK: - Methods
  private func setupCollectionView() {
    
    let customLayout = CollectionVerticalFlowLayout(
      itemsPerRow: 3, margin: 8, lineSpacing: 8,
      interitemSpacing: 8, heightMultiplier: 1.5)
    
    collectionView.collectionViewLayout = customLayout
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(
      MoviesListCell.self,
      forCellWithReuseIdentifier: MoviesListCell.reuseId)
  }
  
}


// MARK: - UICollectionViewDataSource
extension MoviesListViewController: UICollectionViewDataSource {
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
      20
    }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: MoviesListCell.reuseId, for: indexPath) as! MoviesListCell
      cell.posterImageView.image = UIImage(named: "testImage")
      return cell

    }
  
}


// MARK: - UICollectionViewDelegate
extension MoviesListViewController: UICollectionViewDelegate {}

