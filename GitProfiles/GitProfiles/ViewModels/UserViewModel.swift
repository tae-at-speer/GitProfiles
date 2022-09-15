//
//  UserViewModel.swift
//  GitProfiles
//
//  Created by Mithun Karun Suma on 2022-09-14.
//

import Foundation

struct UserViewModel {
    
    //MARK: - Get Following List - API
    func getFollowingList(user: User?, completion: @escaping((_ followingUsers: [User]?, Error?)->Void)){
        guard let userName = user?.login else { return }
        let urlPath = String(format: URLEndpoint.following, userName)
        NetworkManager.shared.makeNetworkCall(urlPath, parms: nil, method: "GET") {(result: Result<[User], Error>) in
                switch result {
                case .success(let success):
                    let followingList = success
                    completion(followingList, nil)
                case .failure(let failure):
                    completion(nil, failure)
                    print("Error", failure.localizedDescription)
                }
            }
    }
    //MARK: - Get Followers List - API
    func getFollowerList(user: User?, completion: @escaping((_ followerUsers: [User]?, Error?)->Void)){
        guard let userName = user?.login else { return }
        let urlPath = String(format: URLEndpoint.followers, userName)
        NetworkManager.shared.makeNetworkCall(urlPath, parms: nil, method: "GET") {(result: Result<[User], Error>) in
            switch result {
            case .success(let success):
                let followingList = success
                completion(followingList, nil)
            case .failure(let failure):
                completion(nil, failure)
                print("Error", failure.localizedDescription)
            }
        }
    }
    //MARK: - Search Profile - API
    func searchUser(query:String,completion: @escaping((_ users: User?, Error?)->Void)){
        let urlPath = String(format: URLEndpoint.user, query.lowercased())
       NetworkManager.shared.makeNetworkCall(urlPath, parms: nil, method: "GET") {(result: Result<User, Error>) in
            switch result {
            case .success(let success):
                let followingList = success
                completion(followingList, nil)
            case .failure(let failure):
                completion(nil, failure)
                print("Error", failure.localizedDescription)
            }
        }
    }
    
}
