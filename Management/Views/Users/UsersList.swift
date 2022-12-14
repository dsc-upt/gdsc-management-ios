//
// Created by Dan Percic on 03.12.2022.
//

import Foundation
import SwiftUI

struct UsersList: View {
    @StateObject private var modelData = UserDataModel()
    @State private var showFavoritesOnly = false

    var filteredUsers: [User] {
        (modelData.users ?? []).filter { user in
            !showFavoritesOnly || user.avatar != nil
        }
    }

    var body: some View {
        let userList = List {
            Toggle(isOn: $showFavoritesOnly) {
                Text("Admins only")
            }

            ForEach(filteredUsers) { user in
                NavigationLink {
                    UserDetail(user: user)
                } label: {
                    UserRow(user: user)
                }
            }
        }

        userList.navigationTitle("Users").task {
            guard modelData.users == nil else {
                print("return")
                return
            }
            do {
                try await modelData.fetchUsers()
            } catch {
                print(error)
            }
        }
    }
}

// struct UserList_Previews: PreviewProvider {
//    static var previews: some View {
//        let deviceName = "iPhone 13 Pro Max"
//        UserList()
//                .environmentObject(ModelData())
//                .previewDevice(PreviewDevice(rawValue: deviceName))
//                .previewDisplayName(deviceName)
//    }
// }
