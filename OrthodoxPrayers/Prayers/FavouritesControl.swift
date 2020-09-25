//
//  FavouritesControl.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 27/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class FavouritesControl: UISegmentedControl {
    let padding = UIEdgeInsets(top: 1, left: 15, bottom: 1, right: 15)
    
    init() {
        super.init(frame: .zero)
        layoutMargins = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        insertSegment(withTitle: "Toate", at: 0, animated: false)
        insertSegment(withTitle: "Favorite", at: 1, animated: false)
        selectedSegmentIndex = 0
        backgroundColor = UIColor(named: "favouritesBgColor") // default background color
        tintColor = UIColor(named: "favouritesBgColor") // selected background color
        selectedSegmentTintColor = UIColor(named: "favouritesSelectedColor")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let fitSize = super.sizeThatFits(size)
        let fitSizeWithPadding = CGSize(width: fitSize.width + padding.left + padding.right,
                                        height: fitSize.height + padding.top + padding.bottom)
        return fitSizeWithPadding
    }
}
