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
  
  // MARK: - ViewModel
  var viewModel: MoviesListViewModelProtocol? {
    didSet {
      viewModel?.getMovies {
        self.collectionView.reloadData()
      }
    }
  }
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setUpLongPressGesture()
  }
  
  // MARK: - Methods
  private func setupCollectionView() {
    let customLayout = CollectionVerticalFlowLayout(
      itemsPerRow: 2, margin: 8, lineSpacing: 8,
      interitemSpacing: 8, heightMultiplier: 1.5)
    
    collectionView.collectionViewLayout = customLayout
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(
      MoviesListCell.self,
      forCellWithReuseIdentifier: MoviesListCell.reuseId)
  }
  
  private func setUpLongPressGesture() {
    let longPress = UILongPressGestureRecognizer()
    longPress.minimumPressDuration = 0.5
    longPress.delaysTouchesBegan = true
    longPress.delegate = self
    longPress.addTarget(self, action: #selector(handleLongPress))
    self.collectionView.addGestureRecognizer(longPress)
  }
  
  @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
    if gesture.state != .ended {
      return
    }
    let pressCoordinates = gesture.location(in: self.collectionView)
    let indexPath = self.collectionView.indexPathForItem(at: pressCoordinates)
    
    if let index = indexPath {
      _ = self.collectionView.cellForItem(at: index)
      // Выполняем нужную функцию с ячейкой
      print(viewModel?.nowPlayingMovies[indexPath!.item].title ?? "")
      showHUDView(with: "ADDED TO FAVORITES")
    } else {
      print("Error: Unable to find indexPath")
    }
  }
  
  private func showHUDView(with message: String) {
    let hud = HUDView()
    hud.showHUD(with: message, andIsHideToTop: true)
    hud.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      hud.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      hud.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
    ])
  }
  
}

// MARK: - UICollectionViewDataSource
extension MoviesListViewController: UICollectionViewDataSource {
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
      viewModel?.numberOfItemsInSection() ?? 0
    }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: MoviesListCell.reuseId,
        for: indexPath) as! MoviesListCell
      cell.viewModel = viewModel?.cellForItemAt(indexPath: indexPath)
      return cell
    }
  
}

// MARK: - UICollectionViewDelegate
extension MoviesListViewController: UICollectionViewDelegate {
  
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath) {
      guard let detailViewModel = viewModel?.didSelectItemAt(indexPath: indexPath) else { return }
      let movieDetailVC = MovieDetailViewController(detailViewModel)
      navigationController?.pushViewController(movieDetailVC, animated: true)
    }
  
}

// MARK: - UIGestureRecognizerDelegate
extension MoviesListViewController: UIGestureRecognizerDelegate {}

