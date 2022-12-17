//
// Created by Dan Percic on 17.12.2022.
//

import Foundation

enum EnvVariables: String {
    case API_URL
    case GOOGLE_CLIENT_ID
}

class Env {
    static let apiUrl = getOrThrow(EnvVariables.API_URL)
    static let googleClientId = getOrThrow(EnvVariables.GOOGLE_CLIENT_ID)

    static func getOrThrow(_ key: EnvVariables) -> String {
        guard let value = ProcessInfo.processInfo.environment[key.rawValue] else {
            fatalError("\(key.rawValue) not set in environment_variables.env")
        }
        return value
    }
}
