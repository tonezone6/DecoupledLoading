//
//  AppCoordinator.swift
//  Stirile ProTV
//
//  Created by Alex on 25/11/2019.
//  Copyright © 2019 Radu Mihaiu. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
   
    func start()
}

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = LoadingViewController(
            resource: Comment.allComments,
            build: { comments in
                return CommentsViewController(comments: comments, coordinator: self)
            }
        )
        vc.title = Constants.Titles.comments.rawValue
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushDetails(id: Int) {
        let vc = LoadingViewController(
            resource: Comment.comment(with: id),
            build: DetailsViewController.init
        )
        vc.title = Constants.Titles.details.rawValue
        navigationController.pushViewController(vc, animated: true)
    }
}
