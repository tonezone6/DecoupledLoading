//
//  CommentsDataSource.swift
//  DecoupledNetworking
//
//  Created by Alex on 20/03/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit

class CommentsDataSource: NSObject, UITableViewDataSource {
    private var cell: UITableViewCell.Type
    private var items: [Comment]
    private var id: String
    
    private var configure: (UITableViewCell, Comment) -> ()

    init<Cell: UITableViewCell>(
        cell: Cell.Type, id: String, items: [Comment],
        configure: @escaping (Cell, Comment) -> ()) {
        
        self.cell = cell
        self.id = id
        self.items = items
        
        self.configure = { cell, comment in
            configure(cell as! Cell, comment)
        }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(cell, forCellReuseIdentifier: id)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        let comment = items[indexPath.row]
        
        configure(cell, comment)
    
        return cell
    }
}
