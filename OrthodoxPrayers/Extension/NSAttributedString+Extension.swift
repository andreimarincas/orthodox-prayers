//
//  NSAttributedString+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 04/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    func glyphs() -> [Glyph] {
        var glyphs = [Glyph]()
        let line = CTLineCreateWithAttributedString(self)
        let glyphRuns = CTLineGetGlyphRuns(line) as! [CTRun]
        for run in glyphRuns {
            glyphs += run.glyphs()
        }
        return glyphs
    }
    
    /*var lettersBezierPaths: [UIBezierPath] {
        var paths = [UIBezierPath]()
        var biggestBoundingBox = CGRect.zero
        for glyph in lettersGlyphs {
            let glyphPath = glyph.cgPath
            // Check if bounding box is bigger
            log("glyph.cgPath.boundingBox: \(glyph.cgPath.boundingBox)")
//            log("glyph.boundingRect: \(glyph.boundingRect)")
//            log("glyph.opticalBounds: \(glyph.opticalBounds)")
            let boundingBox = glyphPath.boundingBox
            if boundingBox.height > biggestBoundingBox.height {
                biggestBoundingBox = boundingBox
            }
            // Create letter bezier path translated by glyph position
            let letterPath = UIBezierPath(cgPath: glyphPath)
            let pos = glyph.position
            let t = CGAffineTransform(translationX: pos.x, y: pos.y)
            letterPath.apply(t)
            paths.append(letterPath)
        }
        for letterPath in paths {
            // Turn letter upside down
            let s = CGAffineTransform(scaleX: 1, y: -1)
            let t = CGAffineTransform(translationX: 0, y: biggestBoundingBox.height)
            letterPath.apply(s)
            letterPath.apply(t)
        }
        return paths
    }
    
    var bezierPath: UIBezierPath {
        let path = UIBezierPath()
        for letterPath in lettersBezierPaths {
            path.append(letterPath)
            //log("letterPath.bounds: \(letterPath.bounds)")
        }
        return path
    }*/
}
