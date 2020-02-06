//
//  Post.swift
//  DecoupledNetworking
//
//  Created by Alex on 06/02/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation

struct Post {
    struct Body1: Encodable {
        let id: Int
        let title: String
    }
    
    struct Body2: Encodable {
        let city: String
        let latitude: Double
        let longitude: Double
    }
}
