//
//  CommentsDelegate.swift
//  DecoupledNetworking
//
//  Created by Alex on 20/03/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit

protocol CommentsPresenting {
    func didSelect(row: Int)
}

class CommentsDelegate: NSObject, UITableViewDelegate {
    var presenting: CommentsPresenting?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenting?.didSelect(row: indexPath.row)
    }
}
