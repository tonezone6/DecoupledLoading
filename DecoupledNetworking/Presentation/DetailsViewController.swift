//
//  PhotoDetailViewController.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit

final class DetailsViewController: UIViewController {
    private var coordinator: AppCoordinator?
    
    private var cardView: CardView!

    convenience init(comment: Comment, coordinator: AppCoordinator?) {
        self.init()
        self.coordinator = coordinator
        self.cardView = CardView(text: comment.body)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardView)
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
    }
}
