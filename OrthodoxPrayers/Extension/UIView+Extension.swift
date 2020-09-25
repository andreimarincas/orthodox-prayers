//
//  UIView+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 23/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

extension UIView {
    /**
     Add subview aligned.
     Add `subview` as subview to `self` and setup constraints to align subview's `leading`, `top`, `trailing` and `bottom` attributes to `self`.
     */
    func addSubviewAligned(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        let constraints = NSLayoutConstraint.constraints(aligning: subview, to: self)
        addSubview(subview)
        addConstraints(constraints)
        layoutIfNeeded()
    }
}
