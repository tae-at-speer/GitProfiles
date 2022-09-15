//
//  UserListTableViewCell.swift
//  GitProfiles
//
//  Created by Mithun Karun Suma on 2022-09-14.
//

import Foundation
import UIKit


class UserListTableViewCell : UITableViewCell {
    let userAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    var user: User? {
        didSet{
            configureCell(user: user)
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        uiSetup()
    }
    //MARK: - UI Setup
    fileprivate func uiSetup(){
        [userAvatar, nameLabel].forEach({ contentView.addSubview($0)})
        
        userAvatar.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trialing: nameLabel.leadingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16), size: .init(width: 45, height: 45))
        nameLabel.anchor(top: userAvatar.topAnchor, bottom: contentView.bottomAnchor, leading: userAvatar.trailingAnchor, trialing: contentView.trailingAnchor, padding: .init(top: userAvatar.frame.width/2, left: 16, bottom: 16, right: 16))

    }
    
    //MARK: - Configure cell
    fileprivate func configureCell(user: User?){
        nameLabel.text = user?.login ?? "Not Available"
        CommonUtils.setImageFrom(url: user?.avatarURL?.relativeString, imageView: userAvatar)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
