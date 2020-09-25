//
//  GlyphView.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 05/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class GlyphView: UIView {
    var character: Character?
    var font = UIFont.boldSystemFont(ofSize: 70)
    var textColor = UIColor.label
    
    var glyph: Glyph? {
        guard let character = self.character else { return nil }
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: textColor]
        let attrString = NSAttributedString(string: String(character), attributes: attrs)
        return attrString.glyphs().first
    }
    
    var filledGlyph: Glyph? {
        guard let character = self.character else { return nil }
        guard let filledFont = font.filled else { return nil }
        let attrs: [NSAttributedString.Key: Any] = [.font: filledFont, .foregroundColor: textColor]
        let attrString = NSAttributedString(string: String(character), attributes: attrs)
        return attrString.glyphs().first
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return glyph?.bounds.size ?? .zero
    }
    
    override func draw(_ rect: CGRect) {
        textColor.setFill()
        UIGlyph(glyph).fill()
    }
}
