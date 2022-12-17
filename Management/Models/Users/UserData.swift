//
// Created by Dan Percic on 12.12.2022.
//

import Foundation

class UserApi: Api {
    typealias ModelType = User
    var modelPath: String = "/api/users/"

    static var shared = UserApi()
}

class UserDataModel: ObservableObject {
    @Published private(set) var users: [User]?
    @Published private(set) var isLoading = false

    func fetchUsers() async throws {
        guard !isLoading else {
            return
        }

        DispatchQueue.main.async {
            self.isLoading = true
        }

        let users: [User]? = await UserApi.shared.get()

        DispatchQueue.main.async {
            self.users = users ?? []
            self.isLoading = false
        }
    }
}
