//
//  User.swift
//  GitProfiles
//
//  Created by Mithun Karun Suma on 2022-09-14.
//

import Foundation

struct User: Codable {
    var name: String?
    var userName: String?
    var userDescription:String?
    var userImageUrl:String?
    var following: Int?
    var followers:Int?
    
//    enum codingKeys: String, CodingKeys {
//        case name
//        case userName
//        case userDescription
//        case userImageUrl
//        case following
//        case followers
//    }
}
