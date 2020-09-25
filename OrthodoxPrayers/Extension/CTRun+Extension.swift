//
//  CTRun+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 04/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import CoreText

extension CTRun {
    
    var numberOfGlyphs: CFIndex {
        return CTRunGetGlyphCount(self)
    }
    
    func glyphs() -> [Glyph] {
        var glyphs = [Glyph]()
        for glyphIndex in 0..<numberOfGlyphs {
            let glyph = Glyph(index: glyphIndex, run: self)
            glyphs.append(glyph)
        }
        return glyphs
    }
}
