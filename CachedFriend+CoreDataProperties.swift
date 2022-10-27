//
//  CachedFriend+CoreDataProperties.swift
//  Friendface
//
//  Created by Franciszek Pol on 26/10/2022.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?

    public var wrappedName: String {
        name ?? "Unknown Friend"
    }
    
}

extension CachedFriend : Identifiable {

}
