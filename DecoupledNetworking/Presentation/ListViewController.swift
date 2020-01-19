//
//  ViewController.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
    private var coordinator: AppCoordinator?
    
    private var source: TableViewDataSource<Comment, SubtitleTableViewCell>?
    private var tableView = UITableView()
    
    convenience init(coordinator: AppCoordinator?, items: [Comment]) {
        self.init()
        self.coordinator = coordinator
        source = TableViewDataSource(
            items: items, reuseIdentifier: SubtitleTableViewCell.reuseIdentifier,
            configuration: { item, row, cell in
                cell.configure(id: item.id, subtitle: item.name)
            },
            selection: { [weak self] item in
                self?.coordinator?.pushDetails(item: item)
            }
        )
        tableView.dataSource = source
        tableView.delegate = source
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        tableView.separatorColor = .gray // using separators as shadow
        tableView.constrainEdges(to: view)
        tableView.register(SubtitleTableViewCell.self,
            forCellReuseIdentifier: SubtitleTableViewCell.reuseIdentifier
        )
    }
}
