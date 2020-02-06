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
        self.closure() // calling our closure instead of resuming any task
    }
}

class MockURLSession: URLSession {
    var data: Data?
    var error: Error?

    typealias Completion = (Data?, URLResponse?, Error?) -> Void
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping Completion) -> URLSessionDataTask {
        return MockURLSessionDataTask {
            completionHandler(self.data, nil, self.error)
        }
    }
}

enum MockError: LocalizedError {
    case unknown
}

extension MockError {
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error."
        }
    }
}

