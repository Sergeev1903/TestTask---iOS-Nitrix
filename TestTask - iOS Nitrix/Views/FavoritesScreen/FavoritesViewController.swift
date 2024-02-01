//
//  FavoritesViewController.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import UIKit

class FavoritesViewController: UIViewController {
  
  // MARK: - Properties
  private let tableView = UITableView()
  
  // MARK: - ViewModel
  private var viewModel: FavoritesViewModelProtocol
  
  // MARK: - Init
  init(_ viewModel: FavoritesViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    print("Sorry! only code, no storyboards")
    return nil
  }
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    configureViewModel()
    configureNavigationBar()
  }
  
  // MARK: - Methods
  override func setEditing(_ editing: Bool, animated: Bool) {
      super.setEditing(editing, animated: animated)
      tableView.setEditing(editing, animated: animated)
  }
  
  private func configureNavigationBar() {
    navigationItem.rightBarButtonItem = editButtonItem
    navigationController?.navigationBar.prefersLargeTitles = false
  }
  
  private func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = .none
    tableView.register(
      FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseId)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  private func configureViewModel() {
    viewModel.getMovies {
      self.tableView.reloadData()
    }
  }
  
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
      viewModel.numberOfRowsInSection()
    }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: FavoritesCell.reuseId, for: indexPath) as! FavoritesCell
      cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
      return cell
    }
  
}


// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
  
  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath) -> CGFloat {
      200
    }
  
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath) {
      let detailViewModel = viewModel.didSelectItemAt(indexPath: indexPath)
      let movieDetailVC = MovieDetailViewController(detailViewModel)
      navigationController?.pushViewController(movieDetailVC, animated: true)
    }
  
  func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath) {
//      if editingStyle == .delete {
//          tableView.deleteRows(at: [indexPath], with: .automatic)
//      }
  }

}


