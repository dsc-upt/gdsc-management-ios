//
//  ManagementApp.swift
//  Management
//
//  Created by Dan Percic on 03.12.2022.
//
//

import SwiftUI

@main
struct ManagementApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
