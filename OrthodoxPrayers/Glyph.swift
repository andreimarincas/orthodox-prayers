//
//  Glyph.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 04/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import CoreText

struct Glyph {
    var index: CFIndex
    var run: CTRun
    
    var cgGlyph: CGGlyph {
        let range = CFRangeMake(index, 1)
        var glyph = CGGlyph()
        CTRunGetGlyphs(run, range, &glyph)
        return glyph
    }
    
//    var position: CGPoint {
//        let range = CFRangeMake(index, 1)
//        var pos = CGPoint()
//        CTRunGetPositions(run, range, &pos)
//        return pos
//    }
    
    var font: CTFont? {
        let attributes = CTRunGetAttributes(run) as! [CFString: Any]
        guard let font = attributes[kCTFontAttributeName] else { return nil }
        return (font as! CTFont)
    }
    
    var cgPath: CGPath? {
        guard let font = self.font else { return nil }
        if let glyphPath = CTFontCreatePathForGlyph(font, cgGlyph, nil) {
            return glyphPath
        }
        return nil
    }
    
    var bounds: CGRect {
        guard let font = self.font else { return .zero }
        var boundingRects = [CGRect()]
        CTFontGetBoundingRectsForGlyphs(font, .default, [cgGlyph], &boundingRects, 1)
        return boundingRects[0]
    }
    
//    var opticalBounds: CGRect {
//        guard let font = self.font else { return .zero }
//        var boundingRects = [CGRect()]
//        CTFontGetOpticalBoundsForGlyphs(font, [cgGlyph], &boundingRects, 1, 0)
//        return boundingRects[0]
//    }
}
