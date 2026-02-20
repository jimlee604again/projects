//
//  CoreDataManager.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/10/26.
//

import Foundation
import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "NightfallSwift")

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data error: \(error)")
            }
        }

        return container
    }()

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func saveContext() {

        let context = context

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Save failed: \(error)")
            }
        }
    }
}
