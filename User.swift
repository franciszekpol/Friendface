//
//  User.swift
//  Friendface
//
//  Created by Franciszek Pol on 26/10/2022.
//

import Foundation

struct User: Codable, Identifiable {
    var age: Int
    var id: UUID
    var name: String
    var address: String
    var company: String
    var email: String
    var about: String
    var registered: Date
    var isActive: Bool
    var tags: [String]
    var friends: [Friend]
}
