//
//  Cache.swift
//  DecoupledNetworking
//
//  Created by Alex on 05/02/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation

extension Resource {
    var keyPrefix: String {
        return "cache-"
    }
    
    var cacheKey: String? {
        guard let urlDescription = request.url?.description,
            let digest = urlDescription.sha1Digest else { return nil }
        return keyPrefix + digest
    }
}

struct Cache {
    private var storage: Storing
    
    init(storage: Storing) {
        self.storage = storage
    }
    
    func load<A: Codable>(_ resource: Resource<A>) -> A? {
        guard let key = resource.cacheKey,
            let data = storage[key] else { return nil }
        return try? JSONDecoder().decode(A.self, from: data)
    }
    
    mutating func save<A: Decodable>(_ data: Data, for resource: Resource<A>) {
        guard resource.request.httpMethod?.lowercased() == "get",
            let key = resource.cacheKey else { return }
        storage[key] = data
    }
}
