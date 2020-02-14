//
//  Model.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation
import Networking

public struct Comment: Codable {
    public let id: Int
    public let name, body: String
}

extension Comment {
    public static var allComments: Resource<[Comment]> {
        let url = Endpoint(path: "/comments").url!
        return Resource(with: url)
    }
    
    public static func comment(with id: Int) -> Resource<[Comment]> {
        let query = URLQueryItem(name: "id", value: "\(id)")
        let url = Endpoint(path: "/comments", query: [query]).url!
        return Resource(with: url)
    }
}
