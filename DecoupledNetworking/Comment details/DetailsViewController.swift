//
//  PhotoDetailViewController.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit
import AppKit

final class DetailsViewController: UIViewController {
    private var cardView: CardView!

    init(comments: [Comment]) {
        if let comment = comments.first {
            cardView = CardView(text: comment.body)
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
