//
//  MovieDetailViewController.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import UIKit

class MovieListDetailViewController: UIViewController {
  
  // TODO: encapsulate views -> MovieListDetailView
  
  // MARK: - Properties
  private let tableView = UITableView()
  
  // MARK: - ViewModel
  private var viewModel: MovieListDetailViewModelProtocol?
  
  // MARK: - Init
  init(_ viewModel: MovieListDetailViewModelProtocol) {
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
    setUpTableView()
    configureViewModel()
  }
  
  // MARK: - Methods
  private func setUpTableView() {
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
    
    // FIXME: -
    guard let mediaBackdropURL = viewModel?.movieItemBackdropURL else {
      return UIView()
    }
    headerImageView.load(url: mediaBackdropURL)
    // FIXME: -
    return headerImageView
  }
  
  private func configureViewModel() {
    viewModel?.getMovieDetails {
      self.tableView.reloadData()
    }
  }
  
}

// MARK: - UITableViewDataSource
extension MovieListDetailViewController: UITableViewDataSource {
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
      5
    }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "Cell", for: indexPath)
      cell.selectionStyle = .none
      cell.textLabel?.numberOfLines = 0
      cell.textLabel?.textAlignment = .left
      
      switch indexPath.row {
      case 0:
        cell.textLabel?.text = viewModel?.movieItemTitleWithReleaseYear
      case 1:
        cell.textLabel?.text = viewModel?.movieItemGenres
      case 2:
        cell.textLabel?.text = viewModel?.movieItemVoteAverage
      case 3:
        cell.textLabel?.text = viewModel?.movieItemReleaseDate
      case 4:
        cell.textLabel?.text = viewModel?.movieItemOverview
      default:
        break
      }
      
      return cell
    }
}

// MARK: - UITableViewDelegate
extension MovieListDetailViewController: UITableViewDelegate {}
