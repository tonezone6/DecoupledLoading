//
//  URLSessionMock.swift
//  DecoupledNetworking
//
//  Created by Alex on 05/02/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        // calling our closure instead of resuming any task
        self.closure()
    }
}

class MockURLSession: URLSession {
    var data: Data?
    var error: Error?
    
    private var config: URLSessionConfiguration
    
    init(configuration: URLSessionConfiguration) {
        self.config = configuration
    }

    typealias Completion = (Data?, URLResponse?, Error?) -> Void

    override func dataTask(with request: URLRequest, completionHandler: @escaping Completion) -> URLSessionDataTask {
        MockURLSessionDataTask {
            completionHandler(self.data, nil, self.error)
        }
    }
}

extension URLSession {
    static var mock: MockURLSession {
        MockURLSession(configuration: .default)
    }
}

enum MockError: LocalizedError {
    case unknown
}

extension MockError {
    var errorDescription: String? {
        switch self {
        case .unknown: return "Unknown error."
        }
    }
}

