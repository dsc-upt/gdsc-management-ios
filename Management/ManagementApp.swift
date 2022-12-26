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
    @StateObject var userAuth = AuthData()

    init() {
        #if DEBUG
        var injectionBundlePath = "/Applications/InjectionIII.app/Contents/Resources"
        #if targetEnvironment(macCatalyst)
        injectionBundlePath = "\(injectionBundlePath)/macOSInjection.bundle"
        #elseif os(iOS)
        injectionBundlePath = "\(injectionBundlePath)/iOSInjection.bundle"
        #endif
        Bundle(path: injectionBundlePath)?.load()
        #endif
    }

    var body: some Scene {
        WindowGroup {
            if (!userAuth.isLoggedIn) {
                Login()
            } else {
                NavigationView {
                    ContentView()
                }
                        .environmentObject(userAuth)
                        .navigationViewStyle(.stack)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
