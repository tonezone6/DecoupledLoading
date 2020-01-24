//
//  LoadingViewController.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit

final class LoadingViewController<T: Codable>: UIViewController {
    typealias Build = (T) -> UIViewController
        
    private var resource: Resource<T>
    private var build: Build
    
    private var webservice: CachedWebservice
    
    private var spinner = UIActivityIndicatorView(style: .large)
    private var retry: RetryView?
    
    init(resource: Resource<T>, build: @escaping Build) {
        self.resource = resource
        self.build = build
        
        webservice = CachedWebservice()

        super.init(nibName: nil, bundle: nil)
        
        loadResource()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 0.94, alpha: 1.0)
        setupSpinner()
    }
}

extension LoadingViewController: RetryViewDelegate {
    func headsupViewDidTapRetry(_: RetryView) {
        retry?.removeFromSuperview()
        loadResource()
    }
}

extension LoadingViewController {
    func loadResource() {
        spinner.startAnimating()
        webservice.load(resource) { [weak self] result in
            self?.spinner.stopAnimating()
            switch result {
            case .failure(let error):
                self?.displayRetry(with: error.localizedDescription)
            case .success(let value):
                if let content = self?.build(value) {
                    self?.add(content: content)
                }
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
    
    private func setupSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        spinner.center(to: view)
        
        spinner.hidesWhenStopped = true
    }
    
    private func displayRetry(with message: String) {
        retry = RetryView(message: message)
        guard let rView = retry else { return }
        
        rView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rView)
        rView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        rView.center(to: view)
        
        rView.delegate = self
    }
}


