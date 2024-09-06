//
//  User.swift
//  FriendFaceChallenge
//
//  Created by David Williams on 9/6/24.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
