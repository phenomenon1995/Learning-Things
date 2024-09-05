//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by David Williams on 8/30/24.
//
import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
