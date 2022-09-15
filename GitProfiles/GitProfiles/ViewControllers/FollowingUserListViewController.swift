//
//  FollowingUserListViewController.swift
//  GitProfiles
//
//  Created by Mithun Karun Suma on 2022-09-14.
//

import Foundation
import UIKit


class FollowingUserListViewController: UITableViewController {
        
    let pullToRefreshControl = UIRefreshControl()
    var viewModel = UserViewModel()
    var user: User?
    var followingUsers: [User]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetup()
        setupTableView()
        getFollowingList()
    }
    
    //MARK: - UI Setup
    fileprivate func uiSetup(){
        
        title = "Following"
    }
    //MARK: - UITableview Setup
    fileprivate func setupTableView(){
        tableView.register(UserListTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.userListCellId)
        
        pullToRefreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(pullToRefreshControl)
    }
    //MARK: - Pull to refresh
    @objc fileprivate func refresh(){
        getFollowingList()
    }
    //MARK: - Get all following users
    fileprivate func getFollowingList(){
        guard let user = user else {
            return
        }
        viewModel.getFollowingList(user: user) { followingUsers, err in
            DispatchQueue.main.async {
                self.pullToRefreshControl.endRefreshing()
            if err != nil{
                print("Error", err?.localizedDescription ?? "")
                return
            }
            self.followingUsers = followingUsers
                self.tableView.reloadData()
            }
        }
    }

}
//MARK: -  UITableview delegate & dataSource
extension FollowingUserListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followingUsers?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  Constants.Identifiers.userListCellId, for: indexPath) as? UserListTableViewCell else {
            return UITableViewCell()
        }
        cell.user = followingUsers?[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = self.followingUsers?[indexPath.row] else {
            return
        }
        CommonUtils.navigateToProfile(from: self, user: user)

    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
