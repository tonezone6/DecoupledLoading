//
//  UIView+AutoLayout.swift
//  Stirile ProTV
//
//  Created by Radu Mihaiu on 19/11/2019.
//  Copyright © 2019 Radu Mihaiu. All rights reserved.
//

import UIKit

protocol AutolayoutType where Self: UIView {}

extension UIView: AutolayoutType {
    var autolayout: AutolayoutType { return self }
}

extension AutolayoutType {
    func constrainEdges(to view: UIView, insets: UIEdgeInsets = .zero) {
        leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: insets.left
        ).isActive = true
     
        trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -insets.right
        ).isActive = true
        
        topAnchor.constraint(
            equalTo: view.topAnchor, constant: insets.top
        ).isActive = true
        
        bottomAnchor.constraint(
            equalTo: view.bottomAnchor, constant: -insets.bottom
        ).isActive = true
    }
    
    func center(to view: UIView) {
        centerXAnchor.constraint(
            equalTo: view.centerXAnchor
        ).isActive = true
        
        centerYAnchor.constraint(
            equalTo: view.centerYAnchor
        ).isActive = true
    }
}
