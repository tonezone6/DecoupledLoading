//
//  WebserviceEndpoint.swift
//  DecoupledNetworking
//
//  Created by Alex on 20/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation

enum Endpoint {
    case items
    case item(id: Int)
}

extension Endpoint {
    var base: String {
        return "https://jsonplaceholder.typicode.com/"
    }
}

extension Endpoint {
    var url: URL {
        switch self {
        case .items:
            return URL(string: base + "comments")!
        case .item(let id):
            return URL(string: base + "comments/\(id)")!
        }
    }
}
