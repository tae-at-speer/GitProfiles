//
//  ProfileViewController.swift
//  GitProfiles
//
//  Created by Mithun Karun Suma on 2022-09-14.
//

import Foundation
import UIKit

class ProfileViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetup()
    }
    //MARK: - UI Setup
    fileprivate func uiSetup(){
        view.backgroundColor = .white
        title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .done, target: self, action: #selector(closeProfileScreen))
    }
    //MARK: - Close Profile
    @objc fileprivate func closeProfileScreen(){
        dismiss(animated: true)
    }
}
