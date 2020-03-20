//
//  CommentsViewController.swift
//  DecoupledNetworking
//
//  Created by Alex on 25/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit

final class CommentsViewController: UIViewController, CommentsPresenting {
    private var coordinator: AppCoordinator
    private var comments: [Comment]
    private var tableView = UITableView()
    
    private var delegate: CommentsDelegate?
    private var dataSource: CommentsDataSource?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(comments: [Comment], coordinator: AppCoordinator) {
        self.comments = comments
        self.coordinator = coordinator
        
        super.init(nibName: nil, bundle: nil)
    
        delegate = CommentsDelegate()
        delegate?.presenting = self
        
        dataSource = CommentsDataSource(
            cell: SubtitleTableViewCell.self,
            id: SubtitleTableViewCell.reuseIdentifier,
            items: comments,
            configure: { (cell, comment) in
                cell.configure(with: comment)
            }
        )
        
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        
        configureViews()
    }
    
    func didSelect(row: Int) {
        coordinator.pushDetails(id: comments[row].id)
    }
    
    private func configureViews() {
        view.backgroundColor = .clear
       
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.constrainEdges(to: view)
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
    }
}
