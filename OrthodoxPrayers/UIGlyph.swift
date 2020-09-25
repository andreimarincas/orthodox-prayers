//
//  UIGlyph.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 05/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class UIGlyph {
    var glyph: Glyph?
    
    init(_ glyph: Glyph? = nil) {
        self.glyph = glyph
    }
    
    var path: CGPath? {
        return glyph?.cgPath
    }
    
    var bounds: CGRect {
        return glyph?.bounds ?? .zero
    }
    
    var bezierPath: UIBezierPath? {
        guard let path = self.path else { return nil }
        let bezierPath = UIBezierPath(cgPath: path)
        // Translate glyph to origin
        let pos = bounds.origin
        let t = CGAffineTransform(translationX: -pos.x, y: -pos.y)
        bezierPath.apply(t)
        // Turn glyph upside down
        let s = CGAffineTransform(scaleX: 1, y: -1)
        bezierPath.apply(s)
        let t2 = CGAffineTransform(translationX: 0, y: bounds.height)
        bezierPath.apply(t2)
        return bezierPath
    }
    
    func fill() {
        bezierPath?.fill()
    }
}
