//
//  HomeViewController.swift
//  GitProfiles
//
//  Created by Mithun Karun Suma on 2022-09-14.
//

import Foundation
import UIKit


class HomeViewController: UIViewController{
    
    let tableview: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = .systemBlue
        tv.separatorInset = .zero
        return tv
    }()
    
    let refreshControl = UIRefreshControl()
    
    let searchBarController = UISearchController(searchResultsController: nil)
    
    var homeCellId = "HomeCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetup()
        setupTableView()
        searchBarSetup()
    }
    
    //MARK: - UI Setup
    fileprivate func uiSetup(){
        view.addSubview(tableview)
        tableview.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trialing: view.trailingAnchor)
        
        title = "Search"
    }
    
    //MARK: - UITableview setup
    fileprivate func setupTableView(){
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(HomeTableViewCell.self, forCellReuseIdentifier: homeCellId)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableview.addSubview(refreshControl)
    }
    //MARK: - Search bar setup
    fileprivate func searchBarSetup(){
        searchBarController.searchResultsUpdater = self
        searchBarController.obscuresBackgroundDuringPresentation = false
        searchBarController.searchBar.placeholder = "Search A profile"
        navigationItem.searchController = searchBarController
        definesPresentationContext = true
    }
    //MARK: - Pull to refresh
    @objc fileprivate func refresh(){
        
    }
    //MARK: - Navigate To Following user lists
    fileprivate func navigateToFollowingUserList(){
        let followingVC = FollowingUserListViewController()
        navigationController?.pushViewController(followingVC, animated: true)
    }
    //MARK: - Navigate To Followers  lists
    fileprivate func navigateToFollowersList(){
        let followersVC = FollowersListViewController()
        navigationController?.pushViewController(followersVC, animated: true)
    }
}
//MARK: -  UITableview delegate & dataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: homeCellId, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.user = ""
        cell.followerButtonTapAction = { self.navigateToFollowersList() }
        cell.followingButtonTapAction = { self.navigateToFollowingUserList()}
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
//MARK: - UISearchResult Protocol
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
