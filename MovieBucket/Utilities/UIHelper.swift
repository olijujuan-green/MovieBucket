//
//  UIHelper.swift
//  MovieBucket
//
//  Created by Olijujuan Green on 5/21/20.
//  Copyright © 2020 Olijujuan Green. All rights reserved.
//

import UIKit

struct UIHelper {
    
    static func createFlowLayout(for view: UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 4
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWIdth                   = availableWidth / 3
        
        let layout                      = UICollectionViewFlowLayout()
        layout.sectionInset             = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize                 = CGSize(width: itemWIdth, height: ((itemWIdth / 2) * 3) + 40)
        
        return layout
    }
    
}
