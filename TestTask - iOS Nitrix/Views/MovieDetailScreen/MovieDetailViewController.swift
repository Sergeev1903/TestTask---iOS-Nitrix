//
//  MovieDetailViewController.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import UIKit

class MovieDetailViewController: UIViewController {
  
  // MARK: - Properties
  private let tableView = UITableView()
  
  // MARK: - ViewModel
  private var viewModel: MovieDetailViewModelProtocol {
    didSet {
      tableView.reloadData()
    }
  }
  
  // MARK: - Init
  init(_ viewModel: MovieDetailViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    print("Sorry! only code")
    return nil
  }
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setuptTableView()
  }
  
  // MARK: - Methods
  private func setuptTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.tableHeaderView = createHeaderView()
    
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: -50),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  private func createHeaderView() -> UIView {
    let headerImageView = UIImageView(
      frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 250))
    headerImageView.contentMode = .scaleAspectFill
    
    guard let mediaBackdropURL = viewModel.mediaBackdropURL else {
      return UIView()
    }
    // FIXME: - 
    headerImageView.load(url: mediaBackdropURL)
    return headerImageView
  }
}


// MARK: - UITableViewDataSource
extension MovieDetailViewController: UITableViewDataSource {
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
      4
    }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "Cell", for: indexPath)
      
      cell.selectionStyle = .none
      cell.textLabel?.numberOfLines = 0
      cell.textLabel?.textAlignment = .left
      
      // FIXME: -
      switch indexPath.row {
      case 0:
        cell.textLabel?.text = viewModel.mediaTitleWithReleaseYear
      case 1:
        cell.textLabel?.text = viewModel.mediaVoteAverage
      case 2:
        cell.textLabel?.text = viewModel.mediaReleaseDate
      case 3:
        cell.textLabel?.text = viewModel.mediaOverview
      default:
        break
      }
      
      return cell
    }
}

// MARK: - UITableViewDelegate
extension MovieDetailViewController: UITableViewDelegate {}
