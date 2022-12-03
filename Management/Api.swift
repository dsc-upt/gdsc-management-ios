//
// Created by Dan Percic on 03.12.2022.
//

import Foundation
import SwiftUI

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> [ModelType]?
    func execute() async throws -> [ModelType]?
}

extension NetworkRequest {
    func load(_ url: URL) async throws -> [ModelType]? {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let value = decode(data) else {
            return nil
        }

        return value
    }

    func loadImage(with url: URL) async throws -> UIImage? {
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
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

class APIRequest<Resource: APIResource> {
    let resource: Resource

    init(resource: Resource) {
        self.resource = resource
    }

    func execute() async throws -> [Resource.ModelType]? {
        try await load(resource.url)
    }
}

extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> [Resource.ModelType]? {
        try? JSONDecoder().decode([Resource.ModelType].self, from: data)
    }
}
