//
//  SelectImageView.swift
//  FaceComparison
//
//  Created by Mark Hawkins on 3/31/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit
import os.log

class BaseSelectImageView: UIView {
    
    var imageView: UIImageView!
    var owningViewController: UIViewController?
    
    let cornerRadius: CGFloat = 20
    let shadowCornerRadius: CGFloat = 10
    let borderWidth: CGFloat = 2
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addTapGesture()
        
        setUpSelectImageView()
        setUpImageView()
    }
}

extension BaseSelectImageView {
    func addTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.onGesturePerformed))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func onGesturePerformed(_ sender: UITapGestureRecognizer) {
        guard let vc = owningViewController else {
            os_log(SelectImageViewErrors.NoOwningController, log: OSLog.default, type: .error)
            return
        }
        
        VCAquireImage().getImageFromSource(on: vc, appliedTo: imageView)
    }
}

//Setup for Select Image View
extension BaseSelectImageView {
    func setUpSelectImageView() {
        setSelectImageShadow()
        setSelectImageCornerRadius()
    }
    
    func setSelectImageCornerRadius() {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
    }
    
    func setSelectImageShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = shadowCornerRadius

        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

//Setup for Image View
extension BaseSelectImageView {
    func setUpImageView() {
        imageView = UIImageView(frame: self.bounds)
        
        imageView.layer.backgroundColor = UIColor.clear.cgColor
        imageView.contentMode = .scaleAspectFill
        
        setImageViewPlus()
        setImageViewCornerRadius()
        setImageViewBorder()
        
        self.addSubview(imageView)
    }
    
    func setImageViewPlus() {
        let label = UILabel(frame: self.bounds)
        label.text = "+"
        label.font = label.font.withSize(48)
        label.textAlignment = .center
        
        self.addSubview(label)
    }
    
    func setImageViewCornerRadius() {
        imageView.layer.cornerRadius = cornerRadius
        imageView.layer.masksToBounds = true
    }
    
    func setImageViewBorder() {
        imageView.layer.borderWidth = borderWidth
        imageView.layer.borderColor = UIColor.lightGray.cgColor
    }
}
