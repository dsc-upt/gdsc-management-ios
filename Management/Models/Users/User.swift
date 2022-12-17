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
    var roles: [String]
}
