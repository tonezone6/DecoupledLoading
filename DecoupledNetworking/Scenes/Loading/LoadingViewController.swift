//
//  LoadingViewController.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit

final class LoadingViewController<A: Codable>: UIViewController {
    typealias Loading = (@escaping (Result<A, Error>) -> ()) -> ()
    typealias Building = (A) -> UIViewController

    private var loadingView: LoadingView
   
    private var loading: Loading
    private var building: Building
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(loading: @escaping Loading, building: @escaping Building) {
        self.loadingView = LoadingView()
        self.loading = loading
        self.building = building
        
        super.init(nibName: nil, bundle: nil)
        load()
        loadingView.retryCallback = { [weak self] in
            self?.load()
        }
    }
    
    override func loadView() {
        super.loadView()
        view = loadingView
    }
    
    private func load() {
        loadingView.startLoading()
        loading() { [weak self] result in
            DispatchQueue.main.async {
                self?.loadingView.stopLoading()
                switch result {
                case .failure(let error):
                    self?.loadingView.display(error)
                case .success(let value):
                    if let controller = self?.building(value) {
                        self?.add(content: controller)
                    }
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
}

