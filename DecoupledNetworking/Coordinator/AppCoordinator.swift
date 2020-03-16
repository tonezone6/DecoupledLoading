//
//  AppCoordinator.swift
//  Stirile ProTV
//
//  Created by Alex on 25/11/2019.
//  Copyright © 2019 Radu Mihaiu. All rights reserved.
//

import UIKit
import SimpleCachedNetworking

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
        let request = Comment.all
        let vc = LoadingViewController(
            loading: { URLSession.shared.load([Comment].self, with: request, completion: $0) },
            building: { CommentsViewController(comments: $0, coordinator: self) }
        )
        vc.title = "Comments"
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushDetails(id: Int) {
        let request = Comment.comment(with: id)
        let vc = LoadingViewController(
            loading: { URLSession.cached.load([Comment].self, fromCache: true, with: request, completion: $0) },
            building: DetailsViewController.init
        )
        vc.title = "Details"
        navigationController.pushViewController(vc, animated: true)
    }
}
