//
//  Friend.swift
//  FriendFaceChallenge
//
//  Created by David Williams on 9/6/24.
//

import Foundation
import SwiftData

@Model
class Friend: Codable{
    var id: String
    var name: String

    enum CodingKeys:String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
     init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
    
    
}
