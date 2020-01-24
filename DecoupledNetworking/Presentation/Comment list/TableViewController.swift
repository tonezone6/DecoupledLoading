//
//  TableViewController.swift
//  DecoupledNetworking
//
//  Created by Alex on 24/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit

final class TableViewController<Item, Cell: UITableViewCell>: UITableViewController {
    private var items: [Item] = []
    private let reuseIdentifier = "Cell"
    
    private var configure: ((Cell, Item) -> Void)?
    public var didSelect: ((Item) -> Void)?
    
    init(items: [Item], configure: @escaping (Cell, Item) -> Void) {
        super.init(style: .plain)
        self.items = items
        self.configure = configure
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(Cell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelect?(item)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? Cell else { fatalError() }
        configure?(cell, items[indexPath.row])
        return cell
    }
}
