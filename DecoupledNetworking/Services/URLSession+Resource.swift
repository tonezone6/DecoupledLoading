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
    init(with url: URL) {
        request = URLRequest(url: url)
        parse = { data in
            Result { try JSONDecoder().decode(A.self, from: data) }
        }
    }
    
    init<B: Encodable>(with url: URL, andBody body: B) {
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
