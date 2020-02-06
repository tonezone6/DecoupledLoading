//
//  Model.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let name, body: String
}

// MARK: Resources
extension Comment {
    static var allComments: Resource<[Comment]> {
        return Resource(url: Endpoint.comments.url)
    }
    
    static func comment(with id: Int) -> Resource<Comment> {
        return Resource(url: Endpoint.comment(id: id).url)
    }
}
