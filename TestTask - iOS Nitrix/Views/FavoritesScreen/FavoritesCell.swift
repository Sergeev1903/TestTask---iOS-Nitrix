//
//  FavoritesCell.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 01.02.2024.
//

import UIKit

class FavoritesCell: UITableViewCell {

  // MARK: - Properties
  static let reuseId = String(describing: FavoritesCell.self)
  
  private let containerView = UIView()
  private let backdropImageView = UIImageView()
  private let gradientLayer = CAGradientLayer()
  private let titleLabel = UILabel()
  
  // MARK: - ViewModel
  var viewModel: FavoritesCellViewModelProtocol? {
    didSet {
      configureFavoritesCell()
    }
  }
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUpContainerView()
    setUpMediaImageView()
    setUpMediaTitle()
  }
  
  required init?(coder: NSCoder) {
    print("Sorry! only code")
    return nil
  }
  
  // MARK: - Methods
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    setUpGradient()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    backdropImageView.image = nil
    titleLabel.text = nil
    backdropImageView.backgroundColor = .darkGray.withAlphaComponent(0.5)
  }
  
  // MARK: - Methods
  private func setUpContainerView() {
    backgroundColor = .clear
    selectionStyle = .none
    
    containerView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(containerView)
    
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(
        equalTo: contentView.topAnchor, constant: 8),
      containerView.leadingAnchor.constraint(
        equalTo: contentView.leadingAnchor, constant: 8),
      containerView.bottomAnchor.constraint(
        equalTo: contentView.bottomAnchor, constant: -8),
      containerView.trailingAnchor.constraint(
        equalTo: contentView.trailingAnchor, constant: -8)
    ])
  }
  
  private func setUpMediaImageView() {
    backdropImageView.contentMode = .scaleAspectFill
    backdropImageView.layer.cornerRadius = 10
    backdropImageView.layer.masksToBounds = true
    backdropImageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    
    containerView.addSubview(backdropImageView)
  }
  
  private func setUpGradient() {
    backdropImageView.addGradientAddSublayer(
      gradientLayer,
      colors: [.black.withAlphaComponent(0.5), .clear],
      startPoint: .bottom,
      endPoint: .top)
  }
  
  private func setUpMediaTitle() {
    titleLabel.numberOfLines = 0
    titleLabel.textAlignment = .center
    titleLabel.font = .boldSystemFont(ofSize: 18)
    titleLabel.textColor = .white
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    containerView.addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(
        equalTo: containerView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(
        equalTo: containerView.leadingAnchor),
      titleLabel.bottomAnchor.constraint(
        equalTo: containerView.bottomAnchor),
      titleLabel.trailingAnchor.constraint(
        equalTo: containerView.trailingAnchor)
    ])
  }
  
  private func configureFavoritesCell() {
    guard let backdropImage = viewModel?.favoriteItemBackdropImage else {
      return
    }
    backdropImageView.image = UIImage(data: backdropImage)
    titleLabel.text = viewModel?.favoriteItemTitleWithReleaseYear
    }
  }

