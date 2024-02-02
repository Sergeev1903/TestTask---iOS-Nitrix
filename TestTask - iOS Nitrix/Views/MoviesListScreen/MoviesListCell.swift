//
//  MoviesListCell.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import UIKit

class MoviesListCell: UICollectionViewCell {
  
  // MARK: - Properties
  static let reuseId = String(describing: MoviesListCell.self)
  private let posterImageView = UIImageView()
  
  // MARK: - ViewModel
  var viewModel: MoviesListCellViewModelProtocol? {
    didSet {
      configurePosterImageView()
    }
  }
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpPosterImageView()
  }
  
  required init?(coder: NSCoder) {
    print("Sorry! only code")
    return nil
  }
  
  // MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    posterImageView.image = nil
    posterImageView.backgroundColor = .darkGray.withAlphaComponent(0.5)
  }
  
  private func setUpPosterImageView() {
    posterImageView.contentMode = .scaleAspectFill
    posterImageView.layer.cornerRadius = 10
    posterImageView.layer.masksToBounds = true
    posterImageView.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(posterImageView)
    
    NSLayoutConstraint.activate([
      posterImageView.topAnchor.constraint(equalTo: topAnchor),
      posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  private func configurePosterImageView() {
    guard let posterURL = viewModel?.movieItemPosterURL else {
      return
    }
    posterImageView.load(url: posterURL)
  }
  
}


