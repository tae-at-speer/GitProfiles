//
//  CommonUtils.swift
//  GitProfiles
//
//  Created by Mithun Karun Suma on 2022-09-14.
//

import Foundation
import UIKit
import Kingfisher


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
    
    //MARK: -Set image from URL
    static func setImageFrom(url: String?, imageView: UIImageView?){
        guard let imgURL = URL.init(string: url ?? "") else {
            return
        }
        let resource = ImageResource(downloadURL: imgURL)
        imageView?.contentMode = .scaleToFill
        imageView?.kf.setImage(with: resource, placeholder: UIImage(systemName: "photo.fill"), options: nil, completionHandler: nil)
    }
}
