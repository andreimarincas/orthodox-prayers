//
//  PrayerTextView.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 08/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerTextView: UIView {
    private(set) var textView: UITextView!
    private(set) var glyphView: GlyphView!
    
    private(set) var attributedText: NSAttributedString?
    private(set) var dropCap: Bool = true
    
    private var layoutManager: PrayerTextLayoutManager!
    
    // MARK: Initialization
    
    init() {
        super.init(frame: .zero)
        configureTextView()
        configureGlyphView()
        layoutManager = PrayerTextLayoutManager(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return layoutManager.sizeThatFits(size)
    }
    
    override var intrinsicContentSize: CGSize {
        return layoutManager.intrinsicContentSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutManager.layoutSubviews()
    }
    
    // MARK: Text & glyph update
    
    func setAttributedText(_ attrText: NSAttributedString?, dropCap: Bool) {
        self.attributedText = attrText
        self.dropCap = dropCap
        updateGlyph()
        updateTextBody()
        // Update glyph exclusion path
        if let glyphPath = layoutManager.glyphExclusionPath {
            textView.textContainer.exclusionPaths = [glyphPath]
        } else {
            textView.textContainer.exclusionPaths = []
        }
        setNeedsLayout()
        invalidateIntrinsicContentSize()
    }
    
    // MARK: Configure subviews (private)
    
    private func configureTextView() {
        textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 2
        textView.backgroundColor = .clear
        addSubview(textView)
    }
    
    private func configureGlyphView() {
        glyphView = GlyphView()
        glyphView.backgroundColor = .clear
        addSubview(glyphView)
    }
    
    // MARK: Text & glyph updates (private)
    
    private func updateGlyph() {
        if let attrText = self.attributedText, attrText.length > 0, dropCap {
            glyphView.character = attrText.string.first
            let attrs = attrText.attributes(at: 0, effectiveRange: nil)
            glyphView.font = attrs[.font] as! UIFont
            glyphView.textColor = attrs[.foregroundColor] as! UIColor
        } else {
            glyphView.character = nil
        }
        glyphView.setNeedsDisplay()
    }
    
    private func updateTextBody() {
        guard let attrText = self.attributedText else {
            textView.attributedText = nil
            return
        }
        if dropCap {
            if attrText.length > 1 {
                let range = NSRange(location: 1, length: attrText.length - 1)
                textView.attributedText = attrText.attributedSubstring(from: range)
            } else {
                textView.attributedText = nil
            }
        } else {
            textView.attributedText = attrText
        }
    }
}
