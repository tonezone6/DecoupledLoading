//
//  ItemsDataSource.swift
//  DecoupledNetworking
//
//  Created by Alex on 18/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit

final class TableViewDataSource<Model, Cell: UITableViewCell>: NSObject, UITableViewDataSource, UITableViewDelegate {
    typealias Row = Int
    typealias Configuration = (Model, Row, Cell) -> ()
    typealias Selection = (Model) -> ()
    
    private let configuration: Configuration
    private let selection: Selection
    
    private var reuseIdentifier: String
    private var items: [Model] = []
        
    init(
        items: [Model], reuseIdentifier: String,
        configuration: @escaping Configuration,
        selection: @escaping Selection) {

        self.items = items
        self.reuseIdentifier = reuseIdentifier
        self.configuration = configuration
        self.selection = selection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? Cell else {
            fatalError()
        }
        let row = indexPath.row
        configuration(items[row], row, cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection(items[indexPath.row])
    }
}
