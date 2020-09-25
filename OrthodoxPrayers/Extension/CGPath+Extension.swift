//
//  CGPath+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 05/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import CoreGraphics

extension CGPath {
    func translated(by offset: CGPoint) -> CGPath? {
        var t = CGAffineTransform(translationX: offset.x, y: offset.y)
        return copy(using: &t)
    }
    
    func scaled(by scaleFactor: CGPoint) -> CGPath? {
        var t = CGAffineTransform(scaleX: scaleFactor.x, y: scaleFactor.y)
        return copy(using: &t)
    }
}
