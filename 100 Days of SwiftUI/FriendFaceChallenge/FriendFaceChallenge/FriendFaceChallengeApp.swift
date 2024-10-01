//
//  FriendFaceChallengeApp.swift
//  FriendFaceChallenge
//
//  Created by David Williams on 9/6/24.
//
import SwiftData
import SwiftUI

@Model
class Test{
    var id: String
    init(id: String) {
        self.id = id
    }
}
@main
struct FriendFaceChallengeApp: App {
    var container = try! ModelContainer(for: User.self)
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
        }

    }
        
}
