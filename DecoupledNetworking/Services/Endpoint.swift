//
//  WebserviceEndpoint.swift
//  DecoupledNetworking
//
//  Created by Alex on 20/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation

enum Endpoint {
    case comments
    case comment(id: Int)
}

extension Endpoint {
    var base: String {
        return "https://jsonplaceholder.typicode.com/"
    }
}

extension Endpoint {
    var url: URL {
        switch self {
        case .comments:
            return URL(string: base + "commentss")!
        case .comment(let id):
            return URL(string: base + "comments/\(id)")!
        }
    }
}
