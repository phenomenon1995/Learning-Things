//
//  User.swift
//  FriendFaceChallenge
//
//  Created by David Williams on 9/6/24.
//

import Foundation
import SwiftData

@Model
class User: Codable{

    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case isActive = "isActive"
        case name = "name"
        case age = "age"
        case company = "company"
        case email = "email"
        case address = "address"
        case about = "about"
        case registered = "registered"
        case tags = "tags"
        case friends = "friends"
    }
    
    init(id: String, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, about: String, registered: Date, tags: [String], friends: [Friend]) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }
    
     required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.isActive  = try container.decode(Bool.self, forKey: .isActive)
        self.name  = try container.decode(String.self, forKey: .name)
        self.age  = try container.decode(Int.self, forKey: .age)
        self.company  = try container.decode(String.self, forKey: .company)
        self.email  = try container.decode(String.self, forKey: .email)
        self.address  = try container.decode(String.self, forKey: .address)
        self.about  = try container.decode(String.self, forKey: .about)
        self.registered  = try container.decode(Date.self, forKey: .registered)
        self.tags  = try container.decode([String].self, forKey: .tags)
        self.friends  = try container.decode([Friend].self, forKey: .friends)
        
    }
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.isActive, forKey: .isActive)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.age, forKey: .age)
        try container.encode(self.company, forKey: .company)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.address, forKey: .address)
        try container.encode(self.about, forKey: .about)
        try container.encode(self.registered, forKey: .registered)
        try container.encode(self.tags, forKey: .tags)
        try container.encode(self.friends, forKey: .friends)
    }
}
