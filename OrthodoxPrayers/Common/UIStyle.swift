//
//  UIStyle.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 21/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

struct UIStyle {
    static var current: UIUserInterfaceStyle = .unspecified {
        didSet {
            if current != oldValue {
                NotificationCenter.default.post(name: NotificationName.userInterfaceDidChange, object: nil)
            }
        }
    }
}

extension UIViewController {
    var currentStyle: UIUserInterfaceStyle {
        return UIStyle.current
    }
}
