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
    
    var glyphPath: CGPath? {
        return glyph?.cgPath
    }
    
    var glyphBounds: CGRect {
        return glyph?.bounds ?? .zero
    }
    
    var bezierPath: UIBezierPath? {
        guard let glyphPath = self.glyphPath else { return nil }
        let bezierPath = UIBezierPath(cgPath: glyphPath)
        // Translate glyph to origin
        let pos = glyphBounds.origin
        let t = CGAffineTransform(translationX: -pos.x, y: -pos.y)
        bezierPath.apply(t)
        // Turn glyph upside down
        let s = CGAffineTransform(scaleX: 1, y: -1)
        bezierPath.apply(s)
        let t2 = CGAffineTransform(translationX: 0, y: glyphBounds.height)
        bezierPath.apply(t2)
        return bezierPath
    }
    
    func fill() {
        bezierPath?.fill()
    }
}
