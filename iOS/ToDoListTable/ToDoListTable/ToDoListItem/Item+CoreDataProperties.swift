//
//  Item+CoreDataProperties.swift
//  ToDoListTable
//
//  Created by Jimmy Lee on 10/18/25.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?

}

extension Item : Identifiable {

}
