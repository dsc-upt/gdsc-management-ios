//
// Created by Dan Percic on 17.12.2022.
// Copyright (c) 2022 Gdsc. All rights reserved.
//

import Foundation
import SwiftUI

struct UserRoles: View {
    @State var roles: [String] = []
    @State var selected: Set<IdentifiableString>

    var body: some View {
        MultiSelector<Text, IdentifiableString>(
                label: Text("Roles"),
                options: roles.map {
                    IdentifiableString(string: $0)
                },
                optionToString: { $0.string },
                selected: $selected
        )
    }
}
