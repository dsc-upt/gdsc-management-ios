//
// Created by Dan Percic on 18.12.2022.
// Copyright (c) 2022 Gdsc. All rights reserved.
//

import Foundation
import SwiftUI

let logo = "https://admin.gdscupt.tech/static/media/gdsc-logo-and-text.e31c5277ddb23aac637a.png"
let googleLogo = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/768px-Google_%22G%22_Logo.svg.png"

struct Login: View {
    @EnvironmentObject var authData: AuthData

    private var singInButtonLabel: some View {
        HStack {
            AsyncSquareImage(googleLogo, width: 30)
            Text("Sign in with Google").font(.title2)
        }
    }

    private var signInButton: some View {
        let button = Button(action: {
            authData.signIn()
        }) {
            singInButtonLabel
        }

        let yellowButton = button.padding().background(Color.yellow)
        return yellowButton.foregroundColor(.blue).cornerRadius(5.0)
    }

    var body: some View {
        VStack {
            AsyncSquareImage(logo).padding(40)
            signInButton
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
