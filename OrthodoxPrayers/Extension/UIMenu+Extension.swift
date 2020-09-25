//
//  UIMenu+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 19/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

extension UIMenu {
    convenience init(items: [UIMenuElement]) {
        self.init(title: "", image: nil, identifier: nil, options: [], children: items)
    }
}
