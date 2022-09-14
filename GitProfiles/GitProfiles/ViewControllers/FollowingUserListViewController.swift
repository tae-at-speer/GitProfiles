//
//  FollowingUserListViewController.swift
//  GitProfiles
//
//  Created by Mithun Karun Suma on 2022-09-14.
//

import Foundation
import UIKit


class FollowingUserListViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetup()
    }
    
    //MARK: - UI Setup
    fileprivate func uiSetup(){
        
        title = "Following"
    }
    
}
