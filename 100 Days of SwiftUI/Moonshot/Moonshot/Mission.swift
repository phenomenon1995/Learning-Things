//
//  Mission.swift
//  Moonshot
//
//  Created by David Williams on 8/26/24.
//

import Foundation

struct Mission: Codable, Identifiable{
    struct CrewRole: Codable{
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: String?
    let crew: Array<CrewRole>
    let description: String
}
