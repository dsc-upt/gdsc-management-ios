//
// Created by Dan Percic on 05.12.2022.
//

import SwiftUI
import GoogleSignIn

class AuthData: ObservableObject {
    @Published var givenName: String = ""
    @Published var avatar: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""

    init() {
        check()
    }

    func checkStatus() {
        if (GIDSignIn.sharedInstance.currentUser != nil) {
            let user = GIDSignIn.sharedInstance.currentUser!
            guard let profile = user.profile else {
                return
            }
            givenName = profile.givenName ?? "Stranger"
            avatar = profile.imageURL(withDimension: 100)!.absoluteString
            isLoggedIn = true
        } else {
            signOut()
        }
    }

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        TokenService.clear()
        isLoggedIn = false
        givenName = "Not Logged In"
        avatar = ""
    }

    func check() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
                self.signOut()
                return
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
                    if let error = error {
                        self.errorMessage = "error: \(error.localizedDescription)"
                        self.signOut()
                        return
                    }

                    let resource = TokensResource()
                    let request = APIRequest(resource: resource)
                    var postRequest = request.makePostRequest(resource.url)
                    postRequest.addValue(user?.authentication.idToken ?? "", forHTTPHeaderField: "token")
                    request.execute(postRequest) { (tokens: Tokens?) in
                        guard let tokens = tokens else {
                            return
                        }
                        TokenService.accessToken = tokens.accessToken
                        TokenService.refreshToken = tokens.refreshToken
                    }
                    self.checkStatus()
                }
        )
    }
}


struct Tokens: Codable {
    let accessToken: String
    let refreshToken: String
}

struct TokensResource: APIResource {
    typealias ModelType = Tokens

    var modelPath: String {
        "auth/authenticate"
    }
}
