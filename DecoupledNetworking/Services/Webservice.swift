//
//  Webservice.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation

typealias Parameters = [String : Any]

enum Method {
    case get, post(Parameters)
}

extension Method {
    var name: String {
        switch self {
        case .get:  return "GET"
        case .post: return "POST"
        }
    }
}

struct Resource<T> {
    let url: URL
    let method: Method
}

extension URLRequest {
    init<T>(resource: Resource<T>) {
        self.init(url: resource.url)
        self.httpMethod = resource.method.name
        if case let .post(parameters) = resource.method {
            self.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
    }
}

extension URLSessionConfiguration {
    static var customTimeout: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 8.0
        return config
    }
}

struct Webservice {
    static func load<T: Decodable>(resource: Resource<T>, completion: @escaping (Result<T, Error>) -> Void) {
        let request = URLRequest(resource: resource)
        
        let session = URLSession(configuration: URLSessionConfiguration.customTimeout)
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    return completion(.failure(error))
                }
                
                let decoder = JSONDecoder()
                if let data = data, let value = try? decoder.decode(T.self, from: data) {
                    completion(.success(value))
                } else {
                    completion(.failure(Failure.decoding))
                }
            }
        }.resume()
    }
}

enum Failure: LocalizedError {
    case decoding
}

extension Failure {
    var errorDescription: String? {
        switch self {
        case .decoding:
            return "There was an error reading the data."
        }
    }
}
