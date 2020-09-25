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
    
    /**
     Load view from nib without owner. The outlets link directly to the view itself.
     */
    static func fromNib<T: UIView>(named nibName: String, bundle: Bundle = .main) -> T {
        guard let view = bundle.loadNibNamed(nibName, owner: nil, options: nil)?.first as? T else {
            fatalError("Nib not found: \(nibName)")
        }
        return view
    }
    
    /**
     Load a custom view from nib.
     
     - Precondition: The nib name and the class name are the same.
     
     Example:
     
         let myView = MyView.fromNib()
         myView.someCustomProperty = 5
     */
    static func fromNib() -> Self {
        return fromNib(named: String(describing: self))
    }
}
