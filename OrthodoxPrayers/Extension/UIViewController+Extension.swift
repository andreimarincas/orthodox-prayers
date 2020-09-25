//
//  UIViewController+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 21/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     Load a custom view-controller from nib.
     
     - Precondition: The nib name and the class name are the same.
     
     Example:
     
         let vc = MyViewController.fromNib()
         vc.someCustomProperty = 5
     */
    static func fromNib() -> Self {
        return self.init(nibName: String(describing: self), bundle: .main)
    }
    
    func addChildController(_ childController: UIViewController) {
        addChild(childController)
        view.addSubviewAligned(childController.view)
        childController.didMove(toParent: self)
    }
    
    var statusBarHeight: CGFloat {
        return view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    var navBarHeight: CGFloat {
        return navigationController?.navigationBar.frame.height ?? 0
    }
    
    var tabBarHeight: CGFloat {
        return tabBarController?.tabBar.frame.height ?? 0
    }
}
