//
//  NavigationController.swift
//  DecoupledNetworking
//
//  Created by Alex on 18/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
        navigationBar.tintColor = .white
        navigationBar.barTintColor = UIColor(white: 0.2, alpha: 1.0)
        navigationBar.shadowImage = UIImage()
        delegate = self
        
        let configuration = UIImage.SymbolConfiguration(
            pointSize: UIFont.systemFontSize, weight: .bold, scale: .large
        )
        let back = UIImage(systemName: "arrow.left", withConfiguration: configuration)
        navigationBar.backIndicatorImage = back
        navigationBar.backIndicatorTransitionMaskImage = back
    }
}

extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
        willShow viewController: UIViewController, animated: Bool) {
        
        // Hide back button text
        let back = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = back
    }
}
