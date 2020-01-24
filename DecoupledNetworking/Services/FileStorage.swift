//
//  FileStorage.swift
//  DecoupledNetworking
//
//  Created by Alex on 20/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation

final class FileStorage {
    private static var baseURL: URL {
        guard let url = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { fatalError() }
        return url
    }
    
    subscript(key: String) -> Data? {
        get {
            let url = FileStorage.baseURL.appendingPathComponent(key)
            return try? Data(contentsOf: url)
        }
        set {
            let url = FileStorage.baseURL.appendingPathComponent(key)
            if let value = newValue {
                try? value.write(to: url)
            } else {
                try? FileManager.default.removeItem(at: url)
            }
        }
    }
    
    static func clear() {
        do {
            try FileManager.default.removeItem(at: baseURL)
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
}
