//
// Created by Dan Percic on 03.12.2022.
//

import Foundation
import SwiftUI

protocol Http {
    associatedtype ModelType
    func get<T: Decodable>(_ url: URL) async -> T?
    func post<T: Decodable>(_ url: URL, body payload: Encodable) async -> T?
}

extension Http {
    func get<T: Decodable>(_ url: URL) async -> T? {
        let result = try? await URLSession.shared.data(from: url)

        return handleResult(result)
    }

    func post<T: Decodable>(_ url: URL, body payload: Encodable) async -> T? {
        let request = getPostRequest(url)
        let body = encode(payload)

        let result = try? await URLSession.shared.upload(for: request, from: body)

        return handleResult(result)
    }

    func handleResult<T: Decodable>(_ result: (Data, URLResponse)?) -> T? {
        guard let (data, _) = result, let value: T = decode(data) else {
            guard let (_, response) = result else {
                print("Oops, no response")
                return nil
            }
            print(response)
            return nil
        }

        return value
    }

    func getPostRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }

    func encode(_ object: Encodable) -> Data {
        let encoded = try? JSONEncoder().encode(object)
        return encoded ?? Data()
    }

    func decode<T: Decodable>(_ data: Data) -> T? {
        try? JSONDecoder().decode(T.self, from: data)
    }
}

protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string: "http://localhost:5286")!
        components.path = "/api" + methodPath
        return components.url!
    }
}

class APIRequest<Resource: APIResource>: Http {
    typealias ModelType = Resource.ModelType
    let resource: Resource

    init(resource: Resource) {
        self.resource = resource
    }
}
