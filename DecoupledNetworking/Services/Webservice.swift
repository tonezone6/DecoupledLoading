//
//  Webservice.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation

enum HTTPMethod<Body> {
    case get
    case post(Body)
}

extension HTTPMethod {
    var value: String {
        switch self {
        case .get:  return "GET"
        case .post: return "POST"
        }
    }
}

struct Resource<A> {
    var request: URLRequest
    let parse: (Data) -> A?
}

extension Resource where A: Decodable {
    var isGetRequest: Bool {
        return request.httpMethod == "GET"
    }
    
    // GET intializer
    init(get url: URL) {
        request = URLRequest(url: url)
        parse = { data in
            try? JSONDecoder().decode(A.self, from: data)
        }
    }
    
    // POST intializer
    init<Body: Encodable>(post url: URL, method: HTTPMethod<Body>) {
        request = URLRequest(url: url)
        request.httpMethod = method.value
        switch method {
        case .get: ()
        case .post(let body):
            let encoder = JSONEncoder()
            request.httpBody = try? encoder.encode(body)
        }
        parse = { data in
            try? JSONDecoder().decode(A.self, from: data)
        }
    }
}

extension URLSessionConfiguration {
    static var customTimeout: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 8.0
        return config
    }
}

extension URLSession {
    func load<A: Codable>(_ resource: Resource<A>, completion: @escaping (A?) -> Void) {
        let session = URLSession(configuration: .customTimeout)
        session.dataTask(with: resource.request) { data, _, _ in
            DispatchQueue.main.async {
                completion(data.flatMap(resource.parse))
            }
        }.resume()
    }
}

//enum WebserviceError: LocalizedError {
//    case parsing
//}
//
//extension WebserviceError {
//    var errorDescription: String? {
//        switch self {
//        case .parsing:
//            return "There was an error reading the data."
//        }
//    }
//}

