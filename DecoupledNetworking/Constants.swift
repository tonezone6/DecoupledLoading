//
//  Endpoint.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation

enum Constants {
    enum Endpoint {
        case items
        case item(id: Int)
        
        private var base: String {
            return "https://jsonplaceholder.typicode.com/"
        }
        var url: URL? {
            switch self {
            case .items:
                return URL(string: base + "comments")
            case .item(let id):
                return URL(string: base + "comments/\(id)")
            }
        }
    }
    
    enum Titles: String {
        case items = "Comments"
        case details = "Details"
    }
}

