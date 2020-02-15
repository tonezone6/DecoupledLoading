//
//  AppCoordinator.swift
//  Stirile ProTV
//
//  Created by Alex on 25/11/2019.
//  Copyright © 2019 Radu Mihaiu. All rights reserved.
//

import UIKit
import Networking
import AppKit

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
    
    var cachedservice: CachedWebservice {
        let filestorage = Filestorage()
        let cache = Cache(storage: filestorage)
        return CachedWebservice(cache: cache)
    }
    
    func start() {
        let resource = Comment.allComments
        let vc = LoadingViewController(
            loading: { self.cachedservice.load(resource, completion: $0) },
            building: { CommentsViewController(comments: $0, coordinator: self) }
        )
        vc.title = "Comments"
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushDetails(id: Int) {
        let resource = Comment.comment(with: id)
        let vc = LoadingViewController(
            loading: { self.cachedservice.load(resource, completion: $0) },
            building: DetailsViewController.init
        )
        vc.title = "Details"
        navigationController.pushViewController(vc, animated: true)
    }
}
