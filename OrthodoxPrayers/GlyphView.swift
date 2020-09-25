//
//  GlyphView.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 05/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class GlyphView: UIView {
    
    var character: Character? {
        didSet {
            setNeedsGlyphPathUpdate()
        }
    }
    
    var font = UIFont.systemFont(ofSize: 17) {
        didSet {
            setNeedsGlyphPathUpdate()
        }
    }
    
    var textColor = UIColor.label
    
    private var attributedText: NSAttributedString? {
        guard let character = self.character else { return nil }
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: textColor]
        return NSAttributedString(string: String(character), attributes: attributes)
    }
    
    private var glyph: Glyph? {
        guard let attributedText = self.attributedText else { return nil }
        let glyphs = attributedText.glyphs()
        return glyphs.first
    }
    
    private var _glyphPath: CGPath?
    var glyphPath: CGPath? {
        get {
            updateGlyphPathIfNeeded()
            return _glyphPath
        }
        set {
            _glyphPath = newValue
        }
    }
    
    private var _glyphBounds = CGRect.zero
    var glyphBounds: CGRect {
        get {
            updateGlyphPathIfNeeded()
            return _glyphBounds
        }
        set {
            _glyphBounds = newValue
        }
    }
    
    // MARK: Calculate glyph path
    
    private var needsGlyphPathUpdate = true
    
    private func setNeedsGlyphPathUpdate() {
        needsGlyphPathUpdate = true
    }
    
    private func updateGlyphPathIfNeeded() {
        if needsGlyphPathUpdate {
            calculateGlyphPath()
            needsGlyphPathUpdate = false
        }
    }
    
    private func calculateGlyphPath() {
        guard let glyph = self.glyph else {
            self.glyphPath = nil
            self.glyphBounds = .zero
            return
        }
        var glyphPath = glyph.cgPath
        let glyphBounds = glyph.bounds
        // Translate glyph path to origin
        let origin = glyphBounds.origin
        let offset = CGPoint(x: -origin.x, y: -origin.y)
        glyphPath = glyphPath?.translated(by: offset)
        // Turn glyph path upside down
        let scaleFactor = CGPoint(x: 1, y: -1)
        glyphPath = glyphPath?.scaled(by: scaleFactor)
        let verticalOffset = CGPoint(x: 0, y: glyphBounds.height)
        glyphPath = glyphPath?.translated(by: verticalOffset)
        self.glyphPath = glyphPath
        self.glyphBounds = glyphBounds
    }
    
//    private var bezierPath: UIBezierPath? {
//        guard let glyphPath = self.glyphPath else { return nil }
//        let bezierPath = UIBezierPath(cgPath: glyphPath)
//        // Translate glyph to origin
//        let pos = glyphBounds.origin
//        let t = CGAffineTransform(translationX: -pos.x, y: -pos.y)
//        bezierPath.apply(t)
//        // Turn glyph upside down
//        let s = CGAffineTransform(scaleX: 1, y: -1)
//        bezierPath.apply(s)
//        let t2 = CGAffineTransform(translationX: 0, y: glyphBounds.height)
//        bezierPath.apply(t2)
//        return bezierPath
//    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        isOpaque = false
    }
    
    convenience init(_ character: Character) {
        self.init()
        self.character = character
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return glyphBounds.size
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return intrinsicContentSize
    }
    
    override func draw(_ rect: CGRect) {
        guard let glyphPath = self.glyphPath else { return }
        let bezierPath = UIBezierPath(cgPath: glyphPath)
        textColor.setFill()
        bezierPath.fill()
    }
}
