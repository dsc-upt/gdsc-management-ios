//
// Created by Dan Percic on 26.12.2022.
// Copyright (c) 2022 Gdsc. All rights reserved.
//

import Foundation
import SwiftUI

let gdscShortLogo = "https://seeklogo.com/images/G/google-developers-logo-F8BF3155AC-seeklogo.com.png"

struct TopBar: View {
    @EnvironmentObject private var authData: AuthData

    var body: some View {
        let stack = HStack {
            AsyncSquareImage(gdscShortLogo, width: 40, height: 23)

            let title = Text("GDSC UPT").font(.title)
            title.fontWeight(.bold).fontDesign(.monospaced)

            Spacer()

            AsyncCircleImage(authData.avatar, width: 40)
        }

        return stack.padding(.leading, 20).padding(.trailing, 20)
    }
}
