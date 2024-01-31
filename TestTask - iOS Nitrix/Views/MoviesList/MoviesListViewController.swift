//
//  ViewController.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 31.01.2024.
//

import UIKit

class MoviesListViewController: UIViewController {
  
  
  //MARK: - Outlets
  @IBOutlet weak var tableView: UITableView!
  
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemGreen
    
    setUpTableView()
  }
  
  
  // MARK: - Methods
  private func setUpTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }
  
}


// MARK: UITableViewDataSource
extension MoviesListViewController: UITableViewDataSource {
  
  func tableView(
    _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    10
  }
  
  func tableView(
    _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    return UITableViewCell()
  }
  
}


// MARK: UITableViewDelegate
extension MoviesListViewController: UITableViewDelegate {}

