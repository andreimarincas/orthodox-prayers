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
}
