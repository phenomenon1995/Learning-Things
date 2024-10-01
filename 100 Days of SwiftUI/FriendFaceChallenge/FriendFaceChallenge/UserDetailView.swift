//
//  UserDetailView.swift
//  FriendFaceChallenge
//
//  Created by David Williams on 9/6/24.
//

import SwiftUI

struct FriendIcon: View {
    let user: User
    var body: some View {
        ZStack{
            Rectangle()
                .clipShape(.rect(cornerRadius: 100))
                .foregroundStyle(user.isActive ? .green : .red)
            Text(user.name)
                .frame(maxWidth: 100)
                .foregroundStyle(.white)
                .font(.title2)
                .bold()
                
        }
        .frame(maxWidth: 150, maxHeight: 100)
    }
}
struct UserDetailView: View {
    var allUsers: [User]
    var user: User
    var friends: [User] = [User]()
    let rows = [ GridItem(.adaptive(minimum: 80))]
    @Binding var path: NavigationPath
    @State private var showingMoreInfo = false
    
    var body: some View {
        VStack{
            Section{
                HStack{
                    Text("\(user.name)")
                        .font(.largeTitle)
                        .padding(20)
                    ActivityIcon(user)
                }
                Text(user.about)
            }
            Section{
                Text("Friends")
                    .font(.title)
                List(friends){friend in
                    NavigationLink(value: friend){
                        HStack{
                            Text(friend.name)
                            Spacer()
                            ActivityIcon(friend)
                        }
                    }
                }
            }
            Spacer()
            Section{
                Button("More Info"){
                    showingMoreInfo = true
                }
            }
        }
        .padding()
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            Button("All Users"){
                path = NavigationPath()
            }
        }
        .sheet(isPresented: $showingMoreInfo){
            VStack(alignment: .leading){
                Text("Company: \(user.company)")
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
                Text("User ID: \(user.id)")
                Text("Active: \(user.isActive ? "Active" : "Inactive")")
            }
            .padding()
            
        }
    }
    
    init(user: User, allUsers: [User], path: Binding<NavigationPath>) {
        self.user = user
        self.allUsers = allUsers
        self._path = path
        var friendIds = [String]()
        for friend in self.user.friends {
            friendIds.append(friend.id)
        }
        self.friends = allUsers.filter{
            friendIds.contains($0.id)
        }
    }
}

#Preview {
    var allUsers = [User]()
    var user1 = User( id: "123456", isActive: true, name: "Jod Gibbles", age: 43, company: "PlaceCorp", email: "shimp@placecorp.com", address: "1349 SOM Center Road, Mayfield Heights, Ohio, 44124", about: "This guy, is for sure a guy", registered: .now, tags: [String](), friends: [Friend]())
    var user2 = User(id: "78912346", isActive: true, name: "David J", age: 43, company: "PlaceCorp", email: "gimp@placecorp.com", address: "9874 SOM Center Road, Mayfield Heights, Ohio, 44124", about: "This guy, is for sure not a guy", registered: .now, tags: [String](), friends: [Friend]())
    
    user1.friends.append(Friend(id: user2.id, name: user2.name))
    user2.friends.append(Friend(id:user1.id, name: user1.name))
    
    allUsers.append(user1)
    allUsers.append(user2)
    @State var apath = NavigationPath()
    return UserDetailView(user: user1, allUsers: allUsers, path: $apath)
}
