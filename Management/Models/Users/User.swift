//
// Created by Dan Percic on 03.12.2022.
//

import Foundation
import SwiftUI

let defaultAvatar = "https://cdn.theatlantic.com/thumbor/dzHqeA2z4xLVYN59r1uSMPqGJEQ=/2076x0:4506x2430/540x540/media/img/mt/2022/09/avatar_rerelease_2/original.jpg"

struct User: Identifiable, Decodable {
    var id: String
    var created: String
    var updated: String
    var firstName: String
    var lastName: String
    var avatar: String?
}

extension User {
    enum CodingKeys: String, CodingKey {
        case id
        case created
        case updated
        case firstName
        case lastName
        case avatar
    }
}

struct UsersResource: APIResource {
    typealias ModelType = User
    var id: String?

    var modelPath: String {
        guard let id = id else {
            return "users"
        }
        return "users/\(id)"
    }
}

class UserDataModel: ObservableObject {
    @Published private(set) var users: [User]?
    @Published private(set) var isLoading = false

    func fetchUsers() async throws {
        guard !isLoading else {
            return
        }

        print("Fetch users")

        DispatchQueue.main.async {
            self.isLoading = true
        }

        let resource = UsersResource()
        let request = APIRequest(resource: resource)
        let users: [User]? = await request.get(resource.url)
        print(users)

        DispatchQueue.main.async {
            self.users = users ?? []
            self.isLoading = false
        }
    }
}
