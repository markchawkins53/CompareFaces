//
//  BaseButton.swift
//  FaceComparison
//
//  Created by Mark Hawkins on 3/31/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

class BaseButton: UIButton {

    let cornerRadius: CGFloat = 20
    let shadowCornerRadius: CGFloat = 10
    
    let borderWidth: CGFloat = 2
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setCornerRadius()
        setShadow()
    }
    
    func setCornerRadius() {
        self.layer.cornerRadius = cornerRadius
    }
    
    func setBorder() {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = shadowCornerRadius

        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
