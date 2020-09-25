//
//  NSLayoutConstraint+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 23/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    static func constraints(aligning view1: UIView, to view2: UIView) -> [NSLayoutConstraint] {
        return [constraint(aligningLeading: view1, to: view2),
                constraint(aligningTop: view1, to: view2),
                constraint(aligningTrailing: view1, to: view2),
                constraint(aligningBottom: view1, to: view2)]
    }
    
    static func constraint(aligningLeading view1: UIView, to view2: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: view1,
            attribute: .leading,
            relatedBy: .equal,
            toItem: view2,
            attribute: .leading,
            multiplier: 1,
            constant: 0)
    }
    
    static func constraint(aligningTrailing view1: UIView, to view2: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: view1,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: view2,
            attribute: .trailing,
            multiplier: 1,
            constant: 0)
    }
    
    static func constraint(aligningTop view1: UIView, to view2: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: view1,
            attribute: .top,
            relatedBy: .equal,
            toItem: view2,
            attribute: .top,
            multiplier: 1,
            constant: 0)
    }
    
    static func constraint(aligningBottom view1: UIView, to view2: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: view1,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view2,
            attribute: .bottom,
            multiplier: 1,
            constant: 0)
    }
}
