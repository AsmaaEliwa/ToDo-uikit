//
//  Item+CoreDataProperties.swift
//  ToDo-uikit
//
//  Created by asmaa gamal  on 17/06/2024.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var title: String?
    @NSManaged public var status: Bool

}

extension Item : Identifiable {

}
