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
    
    // MARK: Load view from nib
    
    /**
     Load view from nib where the view is also the owner. The outlets link to the owner.
     The loaded view will be of the same type and it will be added as a subview.
     */
    func loadFromNib() {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            addSubviewAligned(view)
        } else {
            logWarn("Could not load view from nib: \(String(describing: type(of: self)))")
        }
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
