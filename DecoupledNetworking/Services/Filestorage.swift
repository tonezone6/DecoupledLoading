//
//  FileStorage.swift
//  DecoupledNetworking
//
//  Created by Alex on 20/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import Foundation

protocol Storage {
    subscript(key: String) -> Data? { get set }
    func clear()
}

struct Filestorage {
    private var base: URL {
        guard let url = try? FileManager.default.url(
            for: .documentDirectory, in: .userDomainMask,
            appropriateFor: nil, create: true) else { fatalError() }
        return url
    }
    
    subscript(key: String) -> Data? {
        get {
            let url = base.appendingPathComponent(key)
            return try? Data(contentsOf: url)
        }
        set {
            let url = base.appendingPathComponent(key)
            if let value = newValue {
                try? value.write(to: url)
            } else {
                try? FileManager.default.removeItem(at: url)
            }
        }
    }
    
    func clear() {
        do {
            try FileManager.default.removeItem(at: base)
        } catch(let error) {
            print("filestorage ", error.localizedDescription)
        }
    }
}

extension Filestorage: Storage {}
