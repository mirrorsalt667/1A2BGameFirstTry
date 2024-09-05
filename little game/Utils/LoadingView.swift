//
//  LoadingView.swift
//  little game
//
//  Created by Stephen on 2024/9/5.
//

import Foundation
import UIKit

final class LoadingView {
    private var isSetup = false
    private let loadingView = UIView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let loadingLabel = UILabel()
    
    private func setupLoadingView(_ view: UIView) {
        // Configure the loading view
        loadingView.backgroundColor = UIColor(white: 0.0, alpha: 0.7)
        loadingView.layer.cornerRadius = 10
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure the activity indicator (circle animation)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure the loading label
        loadingLabel.text = "Loading..."
        loadingLabel.textColor = .white
        loadingLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        loadingLabel.textAlignment = .center
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        loadingView.addSubview(activityIndicator)
        loadingView.addSubview(loadingLabel)
        view.addSubview(loadingView)
        
        // Add constraints
        NSLayoutConstraint.activate([
            // Center the loading view in the middle of the parent view
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: 150),
            loadingView.heightAnchor.constraint(equalToConstant: 150),
            
            // Center the activity indicator (circle animation)
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: loadingView.topAnchor, constant: 30),
            
            // Position the loading label below the circle animation
            loadingLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 20),
            loadingLabel.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            loadingLabel.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor),
            loadingLabel.trailingAnchor.constraint(equalTo: loadingView.trailingAnchor)
        ])
    }
    
    func showLoadingView(_ view: UIView) {
        if isSetup {
            loadingView.isHidden = false
        } else {
            setupLoadingView(view)
            isSetup = true
        }
    }
    
    func hidingLoadingView() {
        loadingView.isHidden = true
    }
}
