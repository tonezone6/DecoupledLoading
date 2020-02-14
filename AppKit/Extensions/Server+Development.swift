//
//  Server+Developmnet.swift
//  DecoupledNetworking
//
//  Created by Alex on 09/02/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation
import Networking

public extension Server {
    static var development: Server {
        Server(
            scheme: "https",
            host: "jsonplaceholder.typicode.com"
        )
    }
}

public extension Endpoint {
    init(server: Server = .development, path: String, query: [URLQueryItem]? = nil) {
        self.init(server: server, path: path, queryItems: query)
    }
}
