//
//  PersistenceController.swift
//  BhagavadGeeta
//
//  Created by Devarsh Bhalara on 03/11/23.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "bhagavadgeeta")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }
}
