//
//  CachedUser+CoreDataProperties.swift
//  Friendface
//
//  Created by Franciszek Pol on 26/10/2022.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var cachedFriend: NSSet?

    public var cachedFriendArray: [CachedFriend] {
        print("Count of \(self.wrappedName) friends is: \(cachedFriend?.count ?? 999)")
        let set = cachedFriend as? Set<CachedFriend> ?? []
        if set.isEmpty {
            print("ERROR")
        }
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown address"
    }
    
    public var wrappedAbout: String {
        about ?? "Empty about section"
    }
    
    public var wrappedAge: Int {
        Int(age) // sprawdzić co zwraca Int() w przypadku nila
    }
    
    public var wrappedCompany: String {
        company ?? "Unknown company"
    }
    
    public var wrappedEmail: String {
        email ?? "Unknown email"
    }
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }
    
    public var wrappedRegistered: Date {
        registered ?? Date()
    }
}

// MARK: Generated accessors for cachedFriend
extension CachedUser {

    @objc(addCachedFriendObject:)
    @NSManaged public func addToCachedFriend(_ value: CachedFriend)

    @objc(removeCachedFriendObject:)
    @NSManaged public func removeFromCachedFriend(_ value: CachedFriend)

    @objc(addCachedFriend:)
    @NSManaged public func addToCachedFriend(_ values: NSSet)

    @objc(removeCachedFriend:)
    @NSManaged public func removeFromCachedFriend(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
