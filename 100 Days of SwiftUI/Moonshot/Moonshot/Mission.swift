//
//  Mission.swift
//  Moonshot
//
//  Created by David Williams on 8/26/24.
//

import Foundation

struct Mission: Codable, Identifiable, Hashable{
    struct CrewRole: Codable, Hashable{
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: Array<CrewRole>
    let description: String
    
    var displayName:String {
        "Apollo \(id)"
    }
    var image: String{
        "apollo\(id)"
    }
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
