//
//  ProfileCell.swift
//  GitProfiles
//
//  Created by Mithun Karun Suma on 2022-09-14.
//

import Foundation
import UIKit

class ProfileCell: UITableViewCell {
    
    let userAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        uiSetup()
    }
    
    //MARK: - Cell UI Setup
    fileprivate func uiSetup(){
        contentView.addSubview(userAvatar)
        
        userAvatar.anchorFixedSize(size: .init(width: 150, height: 150))
        userAvatar.anchorCenter(to: contentView, xAnchor: true, yAnchor: true)
        userAvatar.layer.cornerRadius = 20
        userAvatar.layer.masksToBounds = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
