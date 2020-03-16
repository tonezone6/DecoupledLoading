//
//  CardLabel.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit

final class CardView: UIView {
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    convenience init(text: String?) {
        self.init()
            
        label.textAlignment = .center
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.text = text?.capitalized
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.constrainEdges(
            to: self, insets: UIEdgeInsets(value: 32)
        )
        
        layer.cornerRadius = 8.0
        clipsToBounds = true
        backgroundColor = .white
    }
}
