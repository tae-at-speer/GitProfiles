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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetup()
        setupTableView()
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
        
    }

}
//MARK: -  UITableview delegate & dataSource
extension FollowingUserListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  Constants.Identifiers.userListCellId, for: indexPath) as? UserListTableViewCell else {
            return UITableViewCell()
        }
        cell.user = ""
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CommonUtils.navigateToProfile(from: self)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
