//
//  URLEndpoint.swift
//  GitProfiles
//
//  Created by Mithun Karun Suma on 2022-09-14.
//

import Foundation


struct URLEndpoint {
    
    static let baseUrl = "https://api.github.com/"
    static let user = "users/%@"
    static let following = "users/%@/following"
    static let followers = "users/%@/followers"
}
