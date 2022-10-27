//
//  ContentView.swift
//  Friendface
//
//  Created by Franciszek Pol on 28/09/2022.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    @State private var users = [User]()
    
    var body: some View {
        NavigationStack {
            List(cachedUsers, id: \.self)  { user in
                NavigationLink {
                    DetailedView(user: user)
                } label: {
                    VStack(alignment: .leading) {
                        Text(user.wrappedName)
                            .font(.headline)
                        Text(user.isActive ? "Active" : "Not active")
                            .foregroundColor(user.isActive ? .green : .red)
                    }
                }
            }
            .navigationTitle("Users")
        }
        .task {
            await fetchDataFromURL()
            await MainActor.run {
                storeDataIntoCoreData()
            }
        }
    }
    
    func fetchDataFromURL() async {
        if(users.isEmpty) {
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                users = try decoder.decode([User].self, from: data)
            } catch {
                print(error)
            }
        }
    }
    
    func storeDataIntoCoreData() {
        for user in users {
            let storedUser = CachedUser(context: moc)
            storedUser.id = user.id
            storedUser.about = user.about
            storedUser.age = Int16(user.age)
            storedUser.address = user.address
            storedUser.company = user.company
            storedUser.email = user.email
            storedUser.address = user.address
            storedUser.isActive = user.isActive
            storedUser.name = user.name
            storedUser.registered = user.registered
            
            for friend in user.friends {
                let newFriend = CachedFriend(context: moc)
                newFriend.name = friend.name
                newFriend.id = friend.id
                newFriend.user = storedUser
            }
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

