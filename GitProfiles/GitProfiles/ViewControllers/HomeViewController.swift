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
    let accountBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: -4, y: -4, width: 40, height: 40))
        btn.layer.cornerRadius  = 20
        btn.layer.masksToBounds = true
        btn.setBackgroundImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        return btn
    }()

    var isSearchBarEmpty: Bool {
      return searchBarController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchBarController.isActive && !isSearchBarEmpty
    }
    
    let refreshControl = UIRefreshControl()
    
    let searchBarController = UISearchController(searchResultsController: nil)
    
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
        
        let accountBarButton = UIBarButtonItem(customView:  accountBtn)
        accountBtn.addTarget(self, action: #selector(navigateToProfile), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = accountBarButton

    }
    
    //MARK: - UITableview setup
    fileprivate func setupTableView(){
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(HomeTableViewCell.self, forCellReuseIdentifier:  Constants.Identifiers.homeCellId)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableview.addSubview(refreshControl)
    }
    //MARK: - Search bar setup
    fileprivate func searchBarSetup(){
        searchBarController.searchResultsUpdater = self
        searchBarController.obscuresBackgroundDuringPresentation = false
        searchBarController.searchBar.placeholder = "Search a profile"
        navigationItem.searchController = searchBarController
        definesPresentationContext = true
        searchBarController.searchBar.delegate = self
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
    //MARK: - Navigate To profile
    @objc fileprivate func navigateToProfile(){
        CommonUtils.navigateToProfile(from: self)
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
        guard let cell = tableview.dequeueReusableCell(withIdentifier:  Constants.Identifiers.homeCellId, for: indexPath) as? HomeTableViewCell else {
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
extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
//        filterContentForSearchText(searchBar.text!, category: category)
    }
}
