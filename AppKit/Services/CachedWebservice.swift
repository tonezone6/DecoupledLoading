//
//  CachedWebservice.swift
//  DecoupledNetworking
//
//  Created by Alex on 20/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation
import Networking

extension URLSession {
    public static var shortTimeout: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 6.0
        return URLSession(configuration: configuration)
    }
}

public class CachedWebservice {
    private var cache: Cache
    
    public init(cache: Cache) {
        self.cache = cache
    }
    
    public func load<A: Codable>(_ resource: Resource<A>, completion: @escaping (Result<A, Error>) -> Void) {
        if let result = cache.load(resource) { print(">>> cache hit <<<")
            return completion(.success(result))
        }
        URLSession.shortTimeout.request(resource) { result in
            switch result {
            case .failure(let error): completion(.failure(error))
            case .success(let value):
                if let data = try? JSONEncoder().encode(value) {
                    self.cache.save(data, for: resource)
                    completion(.success(value))
                }
            }
        }
    }
}
