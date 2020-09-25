//
//  DropCapTextView.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 05/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class DropCapTextView: UIView {
    
    var bodyFont = UIFont.systemFont(ofSize: 17) {
        didSet {
            textView.font = bodyFont
            setNeedsLayout()
        }
    }
    
    var glyphFont = UIFont.boldSystemFont(ofSize: 70) {
        didSet {
            glyphView.font = glyphFont
            setNeedsLayout()
        }
    }
    
    private var textView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .justified
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 2
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    private var glyphView: GlyphView = {
        let glyphView = GlyphView()
        glyphView.textColor = .readingTextHighlightColor
        glyphView.backgroundColor = .clear
        return glyphView
    }()
    
    init() {
        super.init(frame: .zero)
        textView.font = bodyFont
        glyphView.font = glyphFont
        addSubview(textView)
        addSubview(glyphView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var text: String? {
        didSet {
            glyphView.character = text?.first
            if let text = text, text.count > 1 {
                let secondIndex = text.index(after: text.startIndex)
                textView.text = String(text[secondIndex...])
            } else {
                textView.text = ""
            }
            setNeedsLayout()
        }
    }
    
    private var topBodyMargin: CGFloat {
        glyphView.sizeToFit()
        let glyphHeight = glyphView.frame.height
        let bodyFont = textView.font!
        let lineHeight = bodyFont.lineHeight
        guard glyphHeight > lineHeight, lineHeight > 0 else { return 0 }
        let x = glyphHeight / lineHeight // how many lines the glyph takes
        let f = x - CGFloat(Int(x))
        return f * lineHeight
    }
    
    private var preferredBodySize: CGSize {
        guard let superview = self.superview else {
            return textView.sizeThatFits(.zero)
        }
        let fixedWidth = superview.frame.width
        let fixedWidthFlexibleHeight = CGSize(width: fixedWidth, height: .greatestFiniteMagnitude)
        let bodySize = textView.sizeThatFits(fixedWidthFlexibleHeight)
        return CGSize(width: fixedWidth, height: bodySize.height)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let bodySize = self.preferredBodySize
        return CGSize(width: bodySize.width, height: bodySize.height + topBodyMargin)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBodyTextFrame()
        updateGlyphFrame()
        updateGlyphExclusionPath()
    }
    
    private func updateBodyTextFrame() {
        let pos = CGPoint(x: 0, y: topBodyMargin)
        textView.frame = CGRect(origin: pos, size: preferredBodySize)
    }
    
    private func updateGlyphFrame() {
        glyphView.sizeToFit()
        let glyphSize = glyphView.frame.size
        let topLeft = CGPoint(x: glyphSize.width / 2, y: glyphSize.height / 2)
        glyphView.center = topLeft
    }
    
    private func updateGlyphExclusionPath() {
        let glyph = glyphView.filledGlyph ?? glyphView.glyph
        if let glyphPath = UIGlyph(glyph).bezierPath {
            let t = CGAffineTransform(translationX: 0, y: -topBodyMargin)
            glyphPath.apply(t)
            textView.textContainer.exclusionPaths = [glyphPath]
        } else {
            textView.textContainer.exclusionPaths = []
        }
    }
}
