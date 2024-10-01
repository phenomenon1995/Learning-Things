//
//  ContentView.swift
//  FriendFaceChallenge
//
//  Created by David Williams on 9/6/24.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path){
            AllUsersView(path: $path)
                .navigationTitle("FriendFace")
            
        }
    }
}

#Preview {
    ContentView()
}
