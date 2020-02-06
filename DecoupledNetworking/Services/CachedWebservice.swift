//
//  CachedWebservice.swift
//  DecoupledNetworking
//
//  Created by Alex on 20/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation

class CachedWebservice {
    private var cache: ResourceCache
    
    init(cache: ResourceCache) {
        self.cache = cache
    }
    
    func load<A: Codable>(_ resource: Resource<A>, update: @escaping (Result<A, Error>) -> Void) {
        if let result = cache.load(resource) {
            print("cache hit!")
            return update(.success(result))
        }
        
        URLSession.shortTimeout.request(resource) { result in
            switch result {
            case .failure(let error):
                update(.failure(error))
            case .success(let value):
                let encoder = JSONEncoder()
                if let data = try? encoder.encode(value) {
                    self.cache.save(data, for: resource)
                    update(.success(value))
                }
            }
        }
    }
}
