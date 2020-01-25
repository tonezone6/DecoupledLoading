//
//  CommentsViewController.swift
//  DecoupledNetworking
//
//  Created by Alex on 25/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit

final class CommentsViewController: UITableViewController {
    private var coordinator: AppCoordinator
    private var comments: [Comment]
    
    init(comments: [Comment], coordinator: AppCoordinator) {
        self.comments = comments
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.register(
            SubtitleTableViewCell.self,
            forCellReuseIdentifier: SubtitleTableViewCell.reuseIdentifier
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = comments[indexPath.row].id
        coordinator.pushDetails(id: id)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SubtitleTableViewCell.reuseIdentifier, for: indexPath) as? SubtitleTableViewCell else { fatalError() }
        let comment = comments[indexPath.row]
        cell.configure(id: comment.id, subtitle: comment.name)
        return cell
    }
}

