//
//  LoadingViewController.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit
import Networking
import AppKit

final class LoadingViewController<A: Codable>: UIViewController {
    typealias Loading = (@escaping (Result<A, Error>) -> ()) -> ()
    typealias Building = (A) -> UIViewController
    
    private var loading: Loading
    private var building: Building
    
    private var loadingView: LoadingView
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(loading: @escaping Loading, building: @escaping Building) {
        self.loading = loading
        self.building = building
        self.loadingView = LoadingView()
        
        super.init(nibName: nil, bundle: nil)
    
        startLoading()
        loadingView.retryCallback = { [weak self] in
            self?.startLoading()
        }
    }
    
    override func loadView() {
        super.loadView()
        view = loadingView
    }
    
    private func startLoading() {
        loadingView.startLoading()
        loading() { [weak self] result in
            guard let self = self else { return }
            
            self.loadingView.stopLoading()
            switch result {
            case .failure(let error):
                self.loadingView.display(error)
            case .success(let value):
                self.add(content: self.building(value))
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
}

