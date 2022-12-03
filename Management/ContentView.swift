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
    var body: some View {
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
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
