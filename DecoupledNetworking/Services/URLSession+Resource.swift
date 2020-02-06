//
//  Webservice.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation

struct Resource<A> {
    var request: URLRequest
    let parse: (Data) -> Result<A, Error>
}

extension Resource where A: Decodable {
    init(url: URL) {
        request = URLRequest(url: url)
        parse = { data in
            Result { try JSONDecoder().decode(A.self, from: data) }
        }
    }
    
    init<B: Encodable>(post url: URL, body: B) {
        request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(body)
        parse = { data in
            Result { try JSONDecoder().decode(A.self, from: data) }
        }
    }
}

extension URLSession {
    func request<A: Decodable>(_ resource: Resource<A>, completion: @escaping (Result<A, Error>) -> Void) {
        dataTask(with: resource.request) { data, _, error in
            DispatchQueue.main.async {
                let result = data.flatMap { resource.parse($0) } ?? .failure(error!)
                completion(result)
            }
        }.resume()
    }
}

extension URLSession {
    static var shortTimeout: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 8.0
        return URLSession(configuration: configuration)
    }
}
