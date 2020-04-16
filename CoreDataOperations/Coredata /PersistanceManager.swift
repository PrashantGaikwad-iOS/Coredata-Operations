//
//  PersistanceManager.swift
//  CoreDataOperations
//
//  Created by Prashant Gaikwad on 15/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import Foundation
import CoreData

class PersistanceManager {

    private init() {}
    static let shared = PersistanceManager()

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataOperations")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context = persistentContainer.viewContext

    // MARK: - Core Data Saving support
    func save() {
        if context.hasChanges {
            do {
                try context.save()
                print("Data saved")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        do {
            let fetchObjects = try context.fetch(fetchRequest) as? [T]
            return fetchObjects ?? [T]()
        }catch {
            print("error")
            return [T]()
        }
    }

    func delete(_ objectType: NSManagedObject) {
        context.delete(objectType)
        save()
    }
}
