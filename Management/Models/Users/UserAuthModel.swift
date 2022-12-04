//
// Created by Dan Percic on 05.12.2022.
//

import SwiftUI
import GoogleSignIn

class UserAuthModel: ObservableObject {

    @Published var givenName: String = ""
    @Published var profilePicUrl: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""

    init() {
        check()
    }

    func checkStatus() {
        if (GIDSignIn.sharedInstance.currentUser != nil) {
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user = user else {
                return
            }
            let givenName = user.profile?.givenName
            let profilePicUrl = user.profile!.imageURL(withDimension: 100)!.absoluteString
            self.givenName = givenName ?? ""
            self.profilePicUrl = profilePicUrl
            isLoggedIn = true
        } else {
            isLoggedIn = false
            givenName = "Not Logged In"
            profilePicUrl = ""
        }
    }

    func check() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
            }

            self.checkStatus()
        }
    }

    func signIn() {

        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
            return
        }

        let signInConfig = GIDConfiguration.init(clientID: "CLIENT_ID")
        GIDSignIn.sharedInstance.signIn(
                with: signInConfig,
                presenting: presentingViewController,
                callback: { user, error in
                    print(user)
                    print(user?.authentication.idToken)
                    if let error = error {
                        self.errorMessage = "error: \(error.localizedDescription)"
                    }
                    self.checkStatus()
                }
        )
    }

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()
    }
}
