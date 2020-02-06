//
//  String+Digest.swift
//  DecoupledNetworking
//
//  Created by Alex on 05/02/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import CryptoKit

extension String {
    var sha1Digest: String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        let digest = Insecure.SHA1.hash(data: data)
        let hex = digest.map { String(format: "%02x", $0) }.joined()
        return hex
    }
}

