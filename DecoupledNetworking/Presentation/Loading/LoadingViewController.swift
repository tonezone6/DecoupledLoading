//
//  LoadingViewController.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit

final class LoadingViewController<A: Codable>: UIViewController {
    private var spinner: UIActivityIndicatorView!
    private var retry: RetryView?
    
    private var webservice: CachedWebservice!
    private var resource: Resource<A>
    private var build: (A) -> UIViewController
    
    init(resource: Resource<A>, build: @escaping (A) -> UIViewController) {
        self.resource = resource
        self.build = build
        super.init(nibName: nil, bundle: nil)
        
        setupWebservice()
        setupSpinner()
        startLoading()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func startLoading() {
        retry?.removeFromSuperview()
        spinner.startAnimating()
        
        webservice.load(resource) { [weak self] result in
            guard let self = self else { return }
            self.spinner.stopAnimating()
            switch result {
            case .failure(let error):
                self.displayRetry(with: error.localizedDescription)
            case .success(let value):
                self.add(content: self.build(value))
            }
        }
    }
    
    private func add(content: UIViewController) {
        addChild(content)
        content.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(content.view)
        content.view.constrainEdges(to: view)
        content.didMove(toParent: self)
        content.view.alpha = 0
        UIView.animate(withDuration: 0.4) {
            content.view.alpha = 1.0
        }
    }
    
    private func setupWebservice() {
        let storage = Filestorage()
        let cache = Cache(storage: storage)
        webservice = CachedWebservice(cache: cache)
    }
    
    private func setupSpinner() {
        view.backgroundColor = UIColor(white: 0.94, alpha: 1.0)
        
        spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        spinner.center(to: view)
        spinner.hidesWhenStopped = true
    }
    
    private func displayRetry(with message: String) {
        retry = RetryView(message: message, buttonTapped: { [weak self] in
            self?.startLoading()
        })
        guard let retry = retry else { return }
        retry.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(retry)
        retry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        retry.center(to: view)
        retry.isHidden = false
    }
}

