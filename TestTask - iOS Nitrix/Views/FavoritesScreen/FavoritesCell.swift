//
//  FavoritesCell.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 01.02.2024.
//

import UIKit

class FavoritesCell: UITableViewCell {

  // MARK: - Propererties
  static let reuseId = String(describing: FavoritesCell.self)
  
  private let containerView = UIView()
  private let mediaImageView = UIImageView()
  private let gradient = CAGradientLayer()
  private let mediaTitle = UILabel()
  
  // MARK: - ViewModel
  var viewModel: FavoritesCellViewModelProtocol! {
    didSet {
      configureFavoritesCell()
    }
  }
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupContainerView()
    setupMediaImageView()
    setupMediaTitle()
  }
  
  required init?(coder: NSCoder) {
    print("Sorry! only code")
    return nil
  }
  
  // MARK: - Methods
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    setupGradient()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    mediaImageView.image = nil
    mediaTitle.text = nil
    mediaImageView.backgroundColor = .darkGray.withAlphaComponent(0.5)
  }
  
  // MARK: - Methods
  private func setupContainerView() {
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
  
  private func setupMediaImageView() {
    mediaImageView.contentMode = .scaleAspectFill
    mediaImageView.layer.cornerRadius = 10
    mediaImageView.layer.masksToBounds = true
    mediaImageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    
    containerView.addSubview(mediaImageView)
  }
  
  private func setupGradient() {
    mediaImageView.addGradientAddSublayer(
      gradient,
      colors: [.systemBackground.withAlphaComponent(0.5), .clear],
      startPoint: .bottom,
      endPoint: .top)
  }
  
  private func setupMediaTitle() {
    mediaTitle.numberOfLines = 0
    mediaTitle.textAlignment = .center
    mediaTitle.font = .boldSystemFont(ofSize: 18)
    mediaTitle.translatesAutoresizingMaskIntoConstraints = false
    
    containerView.addSubview(mediaTitle)
    
    NSLayoutConstraint.activate([
      mediaTitle.topAnchor.constraint(
        equalTo: containerView.centerYAnchor),
      mediaTitle.leadingAnchor.constraint(
        equalTo: containerView.leadingAnchor),
      mediaTitle.bottomAnchor.constraint(
        equalTo: containerView.bottomAnchor),
      mediaTitle.trailingAnchor.constraint(
        equalTo: containerView.trailingAnchor)
    ])
  }
  
  private func configureFavoritesCell() {
    guard let mediaBackdropURL = viewModel.mediaBackdropURL else {
      return
    }
    mediaImageView.load(url: mediaBackdropURL )
    mediaTitle.text = viewModel.mediaTitleWithReleaseYear
    }
  }

