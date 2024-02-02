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
      configureViewModel()
    }
  }
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpCollectionView()
    setUpLongPressGesture()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureViewModel()
  }
  
  // MARK: - Methods
  private func setUpCollectionView() {
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
    let longPressGesture = UILongPressGestureRecognizer()
    longPressGesture.minimumPressDuration = 0.5
    longPressGesture.delaysTouchesBegan = true
    longPressGesture.delegate = self
    longPressGesture.addTarget(self, action: #selector(handleLongPress))
    self.collectionView.addGestureRecognizer(longPressGesture)
  }
  
  @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
    if gesture.state != .ended {
      return
    }
    let pressCoordinates = gesture.location(in: collectionView)
    let indexPath = collectionView.indexPathForItem(at: pressCoordinates)
    
    if let index = indexPath {
      viewModel?.saveMovieToCoreData(indexPath: index)
      showHUDView(with: "ADDED TO FAVORITES")
    } else {
      print("Error: Unable to find indexPath")
    }
  }
  
  private func showHUDView(with message: String) {
    let hudView = HUDView()
    hudView.showHUD(with: message, andIsHideToTop: true)
    hudView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      hudView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      hudView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
    ])
  }
  
  private func configureViewModel() {
    viewModel?.getMovies {
      self.collectionView.reloadData()
    }
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
      guard let detailViewModel = viewModel?.didSelectItemAt(indexPath: indexPath) else {
        return
      }
      let movieDetailVC = MovieListDetailViewController(detailViewModel)
      navigationController?.pushViewController(movieDetailVC, animated: true)
    }
  
}

// MARK: - UIGestureRecognizerDelegate
extension MoviesListViewController: UIGestureRecognizerDelegate {}

