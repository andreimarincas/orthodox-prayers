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
    var font = UIFont.systemFont(ofSize: 17)
    var textColor = UIColor.label
    
    init(_ character: Character? = nil) {
        self.character = character
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var glyphAttributes: [NSAttributedString.Key: Any] {
        return [.font: font, .foregroundColor: textColor]
    }
    
    var glyph: Glyph? {
        guard let character = self.character else { return nil }
        let attributedString = NSAttributedString(string: String(character), attributes: glyphAttributes)
        return attributedString.glyphs().first
    }
    
    var filledGlyph: Glyph? {
        guard let character = self.character else { return nil }
        guard let filledFont = self.font.filled else { return nil }
        var attributes = self.glyphAttributes
        attributes[.font] = filledFont
        let attributedString = NSAttributedString(string: String(character), attributes: attributes)
        return attributedString.glyphs().first
    }
    
    override var intrinsicContentSize: CGSize {
        return glyph?.bounds.size ?? .zero
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return intrinsicContentSize
    }
    
    override func draw(_ rect: CGRect) {
        textColor.setFill()
        UIGlyph(glyph).fill()
    }
}
