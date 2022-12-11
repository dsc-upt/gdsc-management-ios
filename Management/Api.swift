//
// Created by Dan Percic on 03.12.2022.
//

import Foundation
import SwiftUI
import GoogleSignIn

protocol Http {
    associatedtype ModelType
    func get<T: Decodable>(_ url: URL) async -> T?
    func post<T: Decodable>(_ url: URL, body payload: Encodable) async -> T?
    func execute<T: Decodable>(_ request: URLRequest, withCompletion completion: @escaping (T?) -> Void) -> Void
    func makePostRequest(_ url: URL) -> URLRequest
    func makeGetRequest(_ url: URL) -> URLRequest
}

extension Http {
    func get<T: Decodable>(_ url: URL) async -> T? {
        let result = try? await URLSession.shared.data(for: makeGetRequest(url))
        return handleResult(result)
    }

    func execute<T: Decodable>(_ request: URLRequest, withCompletion completion: @escaping (T?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            let result: T? = handleResult((data, response))
            DispatchQueue.main.async {
                completion(result)
            }
        }
        task.resume()
    }

    func post<T: Decodable>(_ url: URL, body payload: Encodable) async -> T? {
        let request = makePostRequest(url)
        let body = encode(payload)

        let result = try? await URLSession.shared.upload(for: request, from: body)

        return handleResult(result)
    }

    func handleResult<T: Decodable>(_ result: (Data?, URLResponse?)?) -> T? {
        guard let (_, _response) = result, let httpResponse = _response as? HTTPURLResponse
        else {
            print("Error: Invalid response:", result)
            return nil
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            print("Error: Invalid response code:", httpResponse.statusCode)
            return nil
        }

        guard let (data, _) = result, let data = data, let value: T = decode(data) else {
            print("Oops, no response")
            return nil
        }

        return value
    }

    func makeRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        if let accessToken = TokenService.accessToken {
            print(accessToken)
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }

        return request
    }


    func makePostRequest(_ url: URL) -> URLRequest {
        var request = makeRequest(url)
        request.httpMethod = "POST"
        return request
    }

    func makeGetRequest(_ url: URL) -> URLRequest {
        var request = makeRequest(url)
        request.httpMethod = "GET"
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
    var modelPath: String { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string: "http://localhost:5286")!
        components.path = "/api/" + modelPath
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
