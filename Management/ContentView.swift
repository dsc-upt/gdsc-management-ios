//
//  ContentView.swift
//  Management
//
//  Created by Dan Percic on 03.12.2022.
//
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var authData: AuthData

    var body: some View {

        VStack {
            TopBar()
            NavigationView {
                List {
                    NavigationLink {
                        UsersList()
                    } label: {
                        Text("Users")
                    }

                    NavigationLink {
                        ItemsList()
                    } label: {
                        Text("Items")
                    }
                }
            }
                    .navigationViewStyle(.stack)
            if let errorMessage = authData.errorMessage {
                Text(errorMessage)
            }
        }
    }
}

class ContentView_Previews: PreviewProvider {
    static var authData = AuthData()

    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(authData)
    }

    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: ContentView())
    }
    #endif
}
