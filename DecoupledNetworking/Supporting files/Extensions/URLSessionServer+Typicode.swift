//
//  Server+Developmnet.swift
//  DecoupledNetworking
//
//  Created by Alex on 09/02/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation
import SimpleNetworking

public extension URLSession.Server {
    static var main: URLSession.Server {
        URLSession.Server(scheme: "https", host: "jsonplaceholder.typicode.com")
    }
}

public extension URLSession.Endpoint {
    init(path: String, queryItems: [URLQueryItem]? = nil) {
        self.init(server: .main, path: path, queryItems: queryItems)
    }
}
