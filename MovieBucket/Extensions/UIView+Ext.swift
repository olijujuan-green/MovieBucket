//
//  UIView+Ext.swift
//  MovieBucket
//
//  Created by Olijujuan Green on 5/25/20.
//  Copyright © 2020 Olijujuan Green. All rights reserved.
//

import UIKit

extension UIView {
    
    func setBackgroundGradient(firstColor: UIColor, secondColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
