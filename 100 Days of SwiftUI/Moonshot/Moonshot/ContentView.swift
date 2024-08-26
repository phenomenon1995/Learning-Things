//
//  ContentView.swift
//  Moonshot
//
//  Created by David Williams on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    var body: some View {
        VStack {
            Text(String(astronauts.count))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
