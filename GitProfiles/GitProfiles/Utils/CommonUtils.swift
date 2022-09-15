//
//  CommonUtils.swift
//  GitProfiles
//
//  Created by Mithun Karun Suma on 2022-09-14.
//

import Foundation
import UIKit


struct CommonUtils {
   
    //MARK: - Helper for navigation
    static func navigateToProfile(from viewController: UIViewController, user:User){
        let profileVC = ProfileViewController()
        profileVC.user = user
        let navVc = UINavigationController.init(rootViewController: profileVC)
        navVc.modalTransitionStyle = .coverVertical
        navVc.modalPresentationStyle = .fullScreen
        viewController.present(navVc, animated: true)
    }
}
