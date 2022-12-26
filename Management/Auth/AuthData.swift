//
// Created by Dan Percic on 05.12.2022.
//

import SwiftUI
import GoogleSignIn

class AuthData: ObservableObject {
    @Published var givenName: String = ""
    @Published var avatar: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?

    init() {
        restorePreviousSignIn()
    }

    private func checkGoogleCurrentUser() {
        guard let user = GIDSignIn.sharedInstance.currentUser else {
            return signOut()
        }

        guard let profile = user.profile else {
            givenName = "Stranger"
            avatar = defaultAvatar
            isLoggedIn = true
            return
        }

        givenName = profile.givenName ?? "Stranger"
        avatar = profile.imageURL(withDimension: 100)!.absoluteString
        isLoggedIn = true
    }

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        TokenService.clear()
        isLoggedIn = false
        givenName = "Not Logged In"
        avatar = defaultAvatar
    }

    private func restorePreviousSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
                self.signOut()
                return
            }

            self.checkGoogleCurrentUser()
        }
    }

    func signIn() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
            return
        }

        let signInConfig = GIDConfiguration.init(clientID: Env.googleClientId)
        GIDSignIn.sharedInstance.signIn(
                with: signInConfig,
                presenting: presentingViewController,
                callback: { user, error in
                    if let error = error {
                        self.errorMessage = "Error: \(error.localizedDescription)"
                        self.signOut()
                        return
                    }

                    self.errorMessage = nil

                    print("Id token: ", user?.authentication.idToken as Any)
                    TokensApi.shared.authenticate(token: user?.authentication.idToken ?? "")
                    self.checkGoogleCurrentUser()
                }
        )
    }
}
