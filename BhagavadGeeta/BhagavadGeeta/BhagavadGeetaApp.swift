//
//  BhagavadGeetaApp.swift
//  BhagavadGeeta
//
//  Created by Devarsh Bhalara on 30/10/23.
//

import SwiftUI

@main
struct BhagavadGeetaApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            HomeTabBar()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
