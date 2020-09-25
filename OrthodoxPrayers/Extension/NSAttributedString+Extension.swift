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
}
