//
// Created by Dan Percic on 11.12.2022.
//

import Foundation

enum UserDefaultsKeys: String {
    case accessToken
    case refreshToken
}

struct Tokens: Codable {
    let accessToken: String
    let refreshToken: String
}

class TokenService {
    static var accessToken: String? {
        get {
            UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.accessToken.rawValue)
        }
    }

    static var refreshToken: String? {
        get {
            UserDefaults.standard.string(forKey: UserDefaultsKeys.refreshToken.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.refreshToken.rawValue)
        }
    }

    static func clear() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.accessToken.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.refreshToken.rawValue)
    }
}
