//
//  BackBarButtonItem.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 19/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class BackBarButtonItem: UIBarButtonItem {
    var menuTitle: String?
    
    convenience init(title: String, menuTitle: String) {
        self.init(title: title, style: .plain, target: nil, action: nil)
        self.menuTitle = menuTitle
    }
    
    override var menu: UIMenu? {
        set {
            if newValue?.children.last?.title == menuTitle {
                super.menu = newValue
            }
        }
        get {
            return super.menu
        }
    }
}
