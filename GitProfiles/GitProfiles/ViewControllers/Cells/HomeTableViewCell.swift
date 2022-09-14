//
//  HomeTableViewCell.swift
//  GitProfiles
//
//  Created by Mithun Karun Suma on 2022-09-14.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    let userAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let followersButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 0.5
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        return btn
    }()
    
    let followingButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 0.5
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        return btn
    }()
    
    
    var user: String? {
        didSet{
            configureCell(user: user)
        }
    }
    
    var followingButtonTapAction: (()->Void)?
    var followerButtonTapAction: (()->Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        uiSetup()
    }

    //MARK: - Cell UI Setup
    fileprivate func uiSetup(){
        let stackView = UIStackView(arrangedSubviews: [followingButton, followersButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        [stackView, userNameLabel, nameLabel, descriptionLabel, userAvatar].forEach({ contentView.addSubview($0)})
        [followingButton, followersButton].forEach({
            $0.anchorFixedSize(size: .init(width: contentView.frame.width * 45, height: 35))
            $0.setTitleColor(.systemBlue, for: .normal)
        })
        
        userAvatar.anchor(top: contentView.topAnchor, bottom: stackView.topAnchor, leading: contentView.leadingAnchor, trialing: userNameLabel.leadingAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8), size: .init(width: 100, height: 100))
        
        userNameLabel.anchor(top: userAvatar.topAnchor, bottom: nameLabel.topAnchor, leading: userAvatar.trailingAnchor, trialing: contentView.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 8, right: 16))
        
        nameLabel.anchor(top: userNameLabel.bottomAnchor, bottom: descriptionLabel.topAnchor, leading: userNameLabel.leadingAnchor, trialing: userNameLabel.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 8, right: 0))
        
        descriptionLabel.anchor(top: nameLabel.bottomAnchor, bottom: stackView.topAnchor, leading: nameLabel.leadingAnchor, trialing: nameLabel.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 8, right: 0))
        
        stackView.anchor(top: descriptionLabel.bottomAnchor, bottom: contentView.bottomAnchor, leading: userAvatar.trailingAnchor, trialing: contentView.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        
        followingButton.addTarget(self, action: #selector(navigateToFollowingList), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(navigateToFollowingList), for: .touchUpInside)
    }
    
    //MARK: - Configuare Cell
    
    fileprivate func configureCell(user:String?){
        userAvatar.image = #imageLiteral(resourceName: "Mithun.jpeg")
        userNameLabel.text = "User Name"
        nameLabel.text = "Name"
        descriptionLabel.text = "Description"
        
        followingButton.setTitle("Following 8", for: .normal)
        followersButton.setTitle("Followers 888", for: .normal)
    }
    //MARK: - Navigate to Followers list
    @objc fileprivate func navigateToFollowersList(){
        self.followerButtonTapAction?()
    }
    //MARK: - Navigate to Followinf list
    @objc fileprivate func navigateToFollowingList(){
        self.followingButtonTapAction?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
