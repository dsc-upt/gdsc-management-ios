//
// Created by Dan Percic on 03.12.2022.
//

import Foundation
import SwiftUI

struct UserRow: View {
    var user: User

    var body: some View {
        HStack {
            RowAvatar(avatar: user.avatar)

            Text(user.firstName + " " + user.lastName)

            Spacer()

            if user.avatar != nil {
                Image(systemName: "star.fill").foregroundColor(.yellow)
            }
        }
    }
}
