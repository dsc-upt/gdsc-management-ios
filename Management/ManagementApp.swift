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
    @StateObject var userAuth: UserAuthModel = UserAuthModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
                    .environmentObject(userAuth)
                    .navigationViewStyle(.stack)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
