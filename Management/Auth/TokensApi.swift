//
// Created by Dan Percic on 18.12.2022.
// Copyright (c) 2022 Gdsc. All rights reserved.
//

import Foundation

class TokensApi: Api {
    typealias ModelType = Tokens
    var modelPath: String = "/api/auth/authenticate/"

    static var shared = TokensApi()

    func authenticate(token: String) {
        HttpClient.shared.execute(makeRequest(token: token)) { (tokens: Tokens?) in
            guard let tokens = tokens else {
                return
            }
            TokenService.accessToken = tokens.accessToken
            TokenService.refreshToken = tokens.refreshToken
        }
    }

    fileprivate func makeRequest(token: String) -> URLRequest {
        let urlComponents = createUrlComponents();
        var request = HttpClient.shared.makePostRequest(urlComponents.url!)
        request.addValue(token, forHTTPHeaderField: "token")
        return request
    }
}
