//
//  Model.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation
import SimpleNetworking

struct Comment: Codable {
    let id: Int
    let name: String
    let body: String
}

extension Comment {
    static var all: URLRequest {
        let endpoint = URLSession.Endpoint(path: "/comments")
        return URLRequest(url: endpoint.url!)
    }
    
    static func comment(with id: Int) -> URLRequest {
        let id = URLQueryItem(name: "id", value: "\(id)")
        let endpoint = URLSession.Endpoint(path: "/comments", queryItems: [id])        
        return URLRequest(url: endpoint.url!)
    }
}
