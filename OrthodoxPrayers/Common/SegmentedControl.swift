//
//  SegmentedControl.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 09/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class SegmentedControl: UISegmentedControl {
    var padding = UIEdgeInsets()
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return super.sizeThatFits(size).outsetBy(padding)
    }
}
