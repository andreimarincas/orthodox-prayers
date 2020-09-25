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
        let w = width - inset.left - inset.right
        let h = height - inset.top - inset.bottom
        return CGSize(width: w, height: h)
    }
    
    func outsetBy(_ inset: UIEdgeInsets) -> CGSize {
        let w = width + inset.left + inset.right
        let h = height + inset.top + inset.bottom
        return CGSize(width: w, height: h)
    }
}
