//
//  ActivitySpinner.swift
//  FaceComparison
//
//  Created by Mark Hawkins on 3/31/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

class BaseActivitySpinnerController: UIViewController {

    var spinner = UIActivityIndicatorView(style: .large)
    
    override func loadView() {
        super.loadView()
        
        setupView()
        setSpinnerGeneral()
        setSpinnerConstraints()
        
        spinner.startAnimating()
    }
    
    private func setupView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        view.addSubview(spinner)
    }
    
    private func setSpinnerGeneral() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
    }
    
    private func setSpinnerConstraints() {
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}

extension BaseActivitySpinnerController {
    func addTo(viewController vc: UIViewController) {
        vc.addChild(self)
        self.view.frame = vc.view.frame
        vc.view.addSubview(self.view)
        self.didMove(toParent: vc)
    }
    
    func removeFromViewController() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}
