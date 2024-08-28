//
//  ContentView.swift
//  Moonshot
//
//  Created by David Williams on 8/26/24.
//

import SwiftUI
struct ContentView: View {
    @State private var isGrid: Bool = false
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path){
            Group{
                if isGrid { MoonshotGridView(path: $path) } else { MoonshotListView(path: $path) }
            }
                .navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .toolbar{
                    Button{
                        isGrid.toggle()
                    } label: {
                        Text(isGrid ? "List View" : "Grid View")
                            .font(.title3)
                            .bold()
                }
            }
        }
    }
}
struct MoonshotListView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @Binding var path: NavigationPath
    var body: some View {
        NavigationStack{
            List{
                ForEach(missions){mission in
                    NavigationLink(value: mission){
                        HStack(spacing: 30){
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame( width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                            
                            VStack(alignment: .leading){
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                            }
                        }
                    }
                }
                .listRowBackground(Color.darkBackground)
            }
            .listStyle(.plain)
            .navigationDestination(for: Mission.self){ mission in
                MissionView(mission: mission, astronauts: astronauts)
                
            }
        }
    }
}
struct MoonshotGridView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    @Binding var path: NavigationPath
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns) {
                    ForEach(missions){mission in
                        NavigationLink(value: mission){
                            VStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack{
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(90))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationDestination(for: Mission.self){ mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
        }
    }
}

#Preview {
    ContentView()
}
