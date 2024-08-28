//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by David Williams on 8/28/24.
//

import SwiftUI
struct Response: Codable {
    var results: Array<Result>
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()
    @State private var username = ""
    @State private var email = ""
    private var disableForm: Bool {
        username.isEmpty || email.isEmpty
    }
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame(width:200, height: 200)
        Form{
            Section{
                TextField("username", text:$username)
                TextField("Email", text:$email)
            }
            Section{
                Button("Create Account"){
                    print("creating account")
                }
                .disabled(disableForm)
            }
        }
        List(results, id:\.trackId){ item in
            VStack(alignment: .leading){
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }.task{
            await loadData()
        }
    }
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("invalid url")
            return
        }
        do{
            let (data, _) = try await URLSession.shared.data(from:url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
                results = decodedResponse.results
            }
        } catch {
            print("invalid data")
        }
    }
}

#Preview {
    ContentView()
}
