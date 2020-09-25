//
//  CGSize+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 16/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

extension CGSize {
    func insetBy(_ inset: UIEdgeInsets) -> CGSize {
        let newWidth = width - inset.left - inset.right
        let newHeight = height - inset.top - inset.bottom
        return CGSize(width: newWidth, height: newHeight)
    }
    func offsetBy(_ inset: UIEdgeInsets) -> CGSize {
        let newWidth = width + inset.left + inset.right
        let newHeight = height + inset.top + inset.bottom
        return CGSize(width: newWidth, height: newHeight)
    }
}
