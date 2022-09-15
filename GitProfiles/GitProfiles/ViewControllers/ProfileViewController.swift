//
//  ProfileViewController.swift
//  GitProfiles
//
//  Created by Mithun Karun Suma on 2022-09-14.
//

import Foundation
import UIKit

class ProfileViewController: UITableViewController {
    var user: User!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetup()
    }
    //MARK: - UI Setup
    fileprivate func uiSetup(){
        view.backgroundColor = .white
        title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .done, target: self, action: #selector(closeProfileScreen))
        
        tableView.register(ProfileCell.self, forCellReuseIdentifier:  Constants.Identifiers.profileCell)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
    }
    //MARK: - Close Profile
    @objc fileprivate func closeProfileScreen(){
        dismiss(animated: true)
    }
}

extension ProfileViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 4
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.profileCell, for: indexPath) as? ProfileCell else {
                return UITableViewCell()
            }
            CommonUtils.setImageFrom(url: user.avatarURL?.relativeString, imageView:  cell.userAvatar)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = UITableViewCell()
            let userData = ["Username: \(user.login ?? "Not Available")",
                            "Name: \( user.name ?? "Not Available")",
                            "Email: \(user.email ?? "Not Available")",
                            "Bio: \(user.bio ?? "Not Available")"]
            
            cell.textLabel?.text = userData[indexPath.row]
            cell.selectionStyle = .none
            cell.textLabel?.textAlignment = .center
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 150 : UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
