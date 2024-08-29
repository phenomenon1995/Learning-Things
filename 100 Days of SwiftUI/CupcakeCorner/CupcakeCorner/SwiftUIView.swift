//
//  SwiftUIView.swift
//  CupcakeCorner
//
//  Created by David Williams on 8/29/24.
//

import SwiftUI
struct ViewA: View {
    @Binding var path: NavigationPath
    var body: some View {
        Button{
            path.append("A1")
        }label:{
            Text("A1")
                .font(.title)
        }
        Button{
            path.append("A2")
        }label:{
            Text("A2")
                .font(.title)
        }
    }
}

struct ViewB: View {
    @Binding var path: NavigationPath
    var body: some View {
        Button{
            path.append("B1")
        }label:{
            Text("B1")
                .font(.title)
        }
        Button{
            path.append("B2")
        }label:{
            Text("B2")
                .font(.title)
        }
    }
}
struct SwiftUIView: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path){
            Text("Hello, World!")
            Button{
                path.append("A")
            } label: {
                Text("A")
                    .font(.title)
            }
            Button{
                path.append("B")
            } label: {
                Text("B")
                    .font(.title)
            }
         
            .navigationTitle("Test")
            .navigationDestination(for: String.self){selection in
                switch selection {
                case "A":
                    ViewA(path: $path)
                case "B":
                    ViewB(path: $path)
                default:
                    Text("\(selection)")
                        .toolbar{
                            Button{path =  NavigationPath()}label:{Text("Go Home")}
                        }
                }
            }
        }
        
        
    }
}

#Preview {
    SwiftUIView()
}
