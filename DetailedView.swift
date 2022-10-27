//
//  DetailedView.swift
//  Friendface
//
//  Created by Franciszek Pol on 03/10/2022.
//

import SwiftUI

struct DetailedView: View {
    var user: CachedUser
    
    var body: some View {
        List {
            Section {
                Text(user.isActive ? "Active" : "Not active")
                    .foregroundColor(user.isActive ? .green : .red)
                Text("Registered: \(user.wrappedRegistered)")
                Text("Age: \(user.wrappedAge)")
                Text("About: \(user.wrappedAbout)")
            } header: {
                Text("About")
            }
            
            Section {
                Text("Company: \(user.wrappedCompany)")
                Text("Address: \(user.wrappedAddress)")
                Text("Email: \(user.wrappedEmail)")
            } header: {
                Text("Contact details")
            }
            
            Section {
                ForEach(user.cachedFriendArray, id: \.self) { friend in
                    Text(friend.wrappedName)
                }
            } header: {
                Text("Friends")
            }
        }
        .listStyle(.grouped)
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct DetailedView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedView()
//    }
//}
