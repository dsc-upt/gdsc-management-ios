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
    @EnvironmentObject var vm: AuthData

    fileprivate func SignInButton() -> Button<Text> {
        Button(action: {
            vm.signIn()
        }) {
            Text("Sign In")
        }
    }

    fileprivate func SignOutButton() -> Button<Text> {
        Button(action: {
            vm.signOut()
        }) {
            Text("Sign Out")
        }
    }

    fileprivate func ProfilePic() -> some View {
        AsyncImage(url: URL(string: vm.avatar))
                .frame(width: 100, height: 100)
    }

    fileprivate func UserInfo() -> Text {
        Text(vm.givenName)
    }

    var body: some View {
        VStack {
            UserInfo()
            ProfilePic()
            if (vm.isLoggedIn) {
                SignOutButton()
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
            } else {
                SignInButton()
            }
            Text(vm.errorMessage)
        }
                .navigationTitle("Login")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
