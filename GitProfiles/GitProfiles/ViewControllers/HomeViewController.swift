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
    let noResultLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 35))
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textColor = .black
        lbl.text = "Not found"
        lbl.isHidden = true
        return lbl
    }()
    let loader = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    var isSearchBarEmpty: Bool {
      return searchBarController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchBarController.isActive && !isSearchBarEmpty
    }
    var users: [User]? = []
    
    var searchUserWorkItem: DispatchWorkItem?
    let searchBarController = UISearchController(searchResultsController: nil)
    let userViewModel = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetup()
        setupTableView()
        searchBarSetup()
    }
    
    //MARK: - UI Setup
    fileprivate func uiSetup(){
        [tableview, noResultLabel, loader].forEach({view.addSubview($0)})
        [loader, noResultLabel].forEach({tableview.bringSubviewToFront($0)})
        tableview.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trialing: view.trailingAnchor)
        noResultLabel.anchorCenter(to: self.view, xAnchor: true, yAnchor: true)
        noResultLabel.anchorFixedSize(size: .init(width: view.frame.width, height: 30))
        loader.center = view.center
        loader.hidesWhenStopped = true
        title = "Search"
    }
    
    //MARK: - UITableview setup
    fileprivate func setupTableView(){
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(HomeTableViewCell.self, forCellReuseIdentifier:  Constants.Identifiers.homeCellId)
    }
    //MARK: - Search bar setup
    fileprivate func searchBarSetup(){
        searchBarController.obscuresBackgroundDuringPresentation = false
        searchBarController.searchBar.placeholder = "Search a profile"
        navigationItem.searchController = searchBarController
        definesPresentationContext = true
        searchBarController.searchBar.delegate = self
    }
    //MARK: - Navigate To Following user lists
    fileprivate func navigateToFollowingUserList(user: User?){
        let followingVC = FollowingUserListViewController()
        followingVC.user = user
        navigationController?.pushViewController(followingVC, animated: true)
    }
    //MARK: - Navigate To Followers  lists
    fileprivate func navigateToFollowersList(user: User?){
        let followersVC = FollowersListViewController()
        followersVC.user = user
        navigationController?.pushViewController(followersVC, animated: true)
    }
    
    //MARK: - Search
    fileprivate func searchUser(query:String){
        userViewModel.searchUser(query: query) { [weak self] user, err in
            DispatchQueue.main.async {
                self?.loader.stopAnimating()
            if err != nil {
                print("Error", err?.localizedDescription ?? "")
                return
            }
            self?.users?.removeAll()
            guard let user = user else {
                return
            }
            self?.users?.append(user)
                self?.tableview.reloadData()
            }
        }
    }
}
//MARK: -  UITableview delegate & dataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier:  Constants.Identifiers.homeCellId, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.user = users?[indexPath.row]
        cell.followerButtonTapAction = { self.navigateToFollowersList(user: self.users?[indexPath.row]) }
        cell.followingButtonTapAction = { self.navigateToFollowingUserList(user: self.users?[indexPath.row])}
        noResultLabel.isHidden = users?.count ?? 0 != 0
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
//MARK: - UISearchbar delegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchBar = searchBarController.searchBar
        
        if isFiltering {
            loader.startAnimating()
            //Cancel previous task if the user keep on typing to reduce network calls
            self.searchUserWorkItem?.cancel()
            let searchText = searchBar.text!
            let workItem: DispatchWorkItem = DispatchWorkItem {
                self.searchUser(query: searchText)
            }
            self.searchUserWorkItem = workItem
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1), execute: workItem)
        }
    }
}
