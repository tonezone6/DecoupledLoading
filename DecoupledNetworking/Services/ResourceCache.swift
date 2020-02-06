//
//  Cache.swift
//  DecoupledNetworking
//
//  Created by Alex on 05/02/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation

extension Resource {
    var cacheKey: String? {
        guard let urlDescription = request.url?.description,
            let digest = urlDescription.sha1Digest else { return nil }
        return "cache-" + digest
    }
    
    var isGetRequest: Bool {
        return request.httpMethod?.lowercased() == "get"
    }
}

struct ResourceCache {
    private var storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func load<A: Codable>(_ resource: Resource<A>) -> A? {
        guard resource.isGetRequest, let key = resource.cacheKey, let data = storage[key] else { return nil }
        print("cache loaded", key)
        let decoder = JSONDecoder()
        return try? decoder.decode(A.self, from: data)
    }
    
    mutating func save<A: Decodable>(_ data: Data, for resource: Resource<A>) {
        guard resource.isGetRequest, let key = resource.cacheKey else { return }
        print("cache saved", key)
        storage[key] = data
    }
}
