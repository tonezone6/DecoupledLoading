//
//  Webservice.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation

struct Resource<T> {
    let url: URL?
    // more parameters here...
}

enum Failure: LocalizedError {
    case decoding, invalidURL
    
    var errorDescription: String? {
        switch self {
        case .decoding:
            return "There was an error reading the data."
        case .invalidURL:
            return "The URL trying to access is invalid."
        }
    }
}

struct Webservice {
    static func load<T: Decodable>(resource: Resource<T>, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = resource.url else {
            return completion(.failure(Failure.invalidURL))
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 8.0
        let session = URLSession(configuration: configuration)
        
        session.dataTask(with: url) { data, response, error in
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
