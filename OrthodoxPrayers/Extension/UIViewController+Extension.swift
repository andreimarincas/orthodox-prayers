//
//  UIViewController+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 21/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addChildController(_ childController: UIViewController) {
        addChild(childController)
        view.addSubviewAligned(childController.view)
        childController.didMove(toParent: self)
    }
    
    func removeChildController(_ childController: UIViewController) {
        childController.willMove(toParent: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParent()
    }
    
    func transition(from fromChildController: UIViewController, to toChildController: UIViewController, duration: TimeInterval, options: UIView.AnimationOptions = [], completion: ((Bool) -> Void)? = nil) {
        fromChildController.willMove(toParent: nil)
        addChild(toChildController)
        view.addSubviewAligned(toChildController.view)
        UIView.transition(from: fromChildController.view, to: toChildController.view, duration: duration, options: options) { finished in
            fromChildController.view.removeFromSuperview()
            fromChildController.removeFromParent()
            toChildController.didMove(toParent: self)
            completion?(finished)
        }
    }
}
