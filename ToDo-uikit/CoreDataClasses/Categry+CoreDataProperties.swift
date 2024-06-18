//
//  Categry+CoreDataProperties.swift
//  ToDo-uikit
//
//  Created by asmaa gamal  on 17/06/2024.
//
//

import Foundation
import CoreData


extension Categry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categry> {
        return NSFetchRequest<Categry>(entityName: "Categry")
    }

    @NSManaged public var title: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension Categry {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension Categry : Identifiable {

}
