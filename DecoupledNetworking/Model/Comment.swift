//
//  Model.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation

struct Comment: Decodable {
    let id: Int
    let name, body: String
}

// MARK: Resources
extension Comment {
    static var allComments: Resource<[Comment]> {
        return Resource(url: Constants.Endpoint.items.url)
    }
    
    static func comment(with id: Int) -> Resource<Comment> {
        return Resource(url: Constants.Endpoint.item(id: id).url)
    }
}
