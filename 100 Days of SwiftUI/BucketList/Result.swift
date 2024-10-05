//
//  Result.swift
//  BucketList
//
//  Created by David Williams on 10/4/24.
//

import Foundation

struct Result: Codable {
    let query: Query

}

struct Query: Codable {
    let pages : [Int: Page]
}

struct Page: Codable, Comparable {
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
    
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    var description: String {
        terms?["description"]?.first ?? "No Further Information"
    }
    
    
}
