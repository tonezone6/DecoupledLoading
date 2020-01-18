//
//  PhotoDetailViewController.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit

final class DetailsViewController: UIViewController {
    private var cardView: CardView!

    convenience init(comment: Comment) {
        self.init()
        self.cardView = CardView(text: comment.body)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardView)
        cardView.widthAnchor.constraint(
            equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        cardView.autolayout.center(to: view)
    }
}
