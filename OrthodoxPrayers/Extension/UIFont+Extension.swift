//
//  UIFont+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 06/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

extension UIFont {
    var filled: UIFont? {
        return UIFont(name: fontName + "-Filled", size: pointSize)
    }
}
