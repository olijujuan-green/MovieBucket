//
//  UIViewController+Ext.swift
//  MovieBucket
//
//  Created by Olijujuan Green on 5/22/20.
//  Copyright © 2020 Olijujuan Green. All rights reserved.
//

import UIKit

fileprivate var container: UIView!

extension UIViewController {
    
    func displayLoadingView() {
        container = UIView(frame: view.bounds)
        view.addSubview(container)
        container.backgroundColor = .systemBackground
        container.alpha = 0
        UIView.animate(withDuration: 0.2) { container.alpha = 0.75 }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        container.addSubview(activityIndicator)
        view.bringSubviewToFront(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.startAnimating()
        
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            container.removeFromSuperview()
            container = nil
        }
    }
    
}
