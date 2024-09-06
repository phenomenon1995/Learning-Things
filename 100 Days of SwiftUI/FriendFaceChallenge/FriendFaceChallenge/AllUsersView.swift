//
//  AllUsersView.swift
//  FriendFaceChallenge
//
//  Created by David Williams on 9/6/24.
//

import SwiftUI

struct ActivityIcon: View {
    let user : User
    let size: Int
    var body: some View {
        Circle()
            .foregroundColor(user.isActive ? .green : .red)
            .frame(maxWidth: CGFloat(size))
    }
    init(_ user: User, size: Int = 18) {
        self.user = user
        self.size = size
    }
}


struct AllUsersView: View {
    @State private var allUsers = [User]()
    @State private var filteredUsers = [User]()
    @State private var filterBy = "Active"
    @Binding var path: NavigationPath
    
    var body: some View {
        List(allUsers){user in
            NavigationLink(value: user){
                HStack{
                    VStack(alignment: .leading){
                        Text(user.name)
                        Text(user.isActive ? "Active" : "Inactive")
                            .font(.footnote)
                    }
                    .foregroundStyle(user.isActive ? .black : .gray)
                    Spacer()
                    ActivityIcon(user)
                }
            }
        }
        .navigationDestination(for: User.self){user in
            UserDetailView(user: user, allUsers: allUsers, path: $path)
            
        }
        .task{
            await loadData()
        }
    }
    
    func filterUsers(by: String){
        switch by {
        case "Active":
            filteredUsers = allUsers.filter{$0.isActive}
        case "Inactive":
            filteredUsers = allUsers.filter{!$0.isActive}
        default:
            filteredUsers = allUsers
        }
    }
    
    func loadData() async {
        guard let url: URL = URL(string:"https://www.hackingwithswift.com/samples/friendface.json") else {
            print("invalid url")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                allUsers = decodedResponse.sorted{
                    $1.name > $0.name
                }
                
            }
        } catch {
            print("invalid data")
        }
        
    }
}

#Preview {
    @State var path = NavigationPath()
    return AllUsersView(path: $path)
}
