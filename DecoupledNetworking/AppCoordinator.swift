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
        let loadingVC = LoadingViewController(
            resource: Comment.allComments,
            build: { comments in
                let commentsVC = TableViewController(items: comments) { (cell: SubtitleTableViewCell, comment) in
                    cell.configure(id: comment.id, subtitle: comment.name)
                }
                commentsVC.view.backgroundColor = .clear
                commentsVC.didSelect = { [weak self] comment in
                    self?.pushDetails(item: comment)
                }
                return commentsVC
            }
        )
        loadingVC.title = Constants.Titles.comments.rawValue
        navigationController.pushViewController(loadingVC, animated: false)
    }
    
    private func pushDetails(item: Comment) {
        let vc = LoadingViewController(
            resource: Comment.comment(with: item.id),
            build: { comment in
                DetailsViewController(coordinator: self, comment: comment)
            }
        )
        vc.title = Constants.Titles.details.rawValue
        navigationController.pushViewController(vc, animated: true)
    }
}
