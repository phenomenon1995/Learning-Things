//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by David Williams on 8/22/24.
//

import SwiftUI

struct customVM: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.blue)
            .font(.largeTitle)
    }
}

extension View {
    func chungus() -> some View {
        modifier(customVM())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .chungus()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
