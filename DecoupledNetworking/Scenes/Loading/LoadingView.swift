//
//  LoadingView.swift
//  DecoupledNetworking
//
//  Created by Alex on 14/02/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    private var spinner: UIActivityIndicatorView
    private var errorLabel: UILabel
    private var retryButton: UIButton
    private var errorStack: UIStackView
    
    var retryCallback: (() -> ())?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        spinner = UIActivityIndicatorView(style: .large)
        errorLabel = UILabel()
        retryButton = UIButton(type: .custom)
        errorStack = UIStackView()

        super.init(frame: .zero)
        backgroundColor = UIColor(white: 0.94, alpha: 1.0)
        setupSpinner()
        setupErrorStack()
    }
    
    func startLoading() {
        errorStack.isHidden = true
        spinner.startAnimating()
    }
    
    func stopLoading() {
        spinner.stopAnimating()
    }
    
    func display(_ error: Error) {
        errorLabel.text = error.localizedDescription
        errorStack.isHidden = false
    }
}

extension LoadingView {
    private func setupSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        addSubview(spinner)
        spinner.center(to: self)
        spinner.hidesWhenStopped = true
    }
    
    private func setupErrorStack() {
        errorStack.alignment = .fill
        errorStack.axis = .vertical
        errorStack.spacing = 16
        errorStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(errorStack)
        errorStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        errorStack.center(to: self)
        
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .lightGray
        icon.image = UIImage(systemName: "exclamationmark.bubble.fill")
        icon.heightAnchor.constraint(equalToConstant: 32).isActive = true
        errorStack.addArrangedSubview(icon)
        
        errorLabel.textColor = .gray
        errorLabel.font = .systemFont(ofSize: 16)
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorStack.addArrangedSubview(errorLabel)
        
        retryButton.backgroundColor = .white
        retryButton.setTitleColor(.systemBlue, for: .normal)
        retryButton.titleLabel?.font = .systemFont(ofSize: 16)
        retryButton.setTitle("Retry", for: .normal)
        retryButton.layer.cornerRadius = 6.0
        retryButton.addTarget(self, action: #selector(retryTapped(sender:)), for: .touchUpInside)
        retryButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        errorStack.addArrangedSubview(retryButton)
    }
    
    @objc private func retryTapped(sender: UIButton) {
        retryCallback?()
    }
}
