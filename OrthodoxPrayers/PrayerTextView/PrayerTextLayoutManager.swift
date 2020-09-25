//
//  PrayerTextLayoutManager.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 08/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerTextLayoutManager {
    weak var view: PrayerTextView!
    
    init(view: PrayerTextView) {
        self.view = view
    }
    
    func sizeThatFits(_ size: CGSize) -> CGSize {
        let height = self.contentHeight(forWidth: size.width)
        return CGSize(width: size.width, height: height)
    }
    
    var intrinsicContentSize: CGSize {
        guard let superview = view.superview else {
            return .zero
        }
        let width = superview.frame.width
        let height = contentHeight(forWidth: width)
        return CGSize(width: width, height: height)
    }
    
    func layoutSubviews() {
        // Update body text frame
        let textBodyOrigin = CGPoint(x: 0, y: glyphTopOffset)
        textView.frame = CGRect(origin: textBodyOrigin, size: textBodySize)
        // Update glyph frame
        glyphView.sizeToFit()
        let glyphOrigin = CGPoint(x: textView.textContainerInset.left, y: textView.textContainerInset.top)
        let glyphSize = glyphView.frame.size
        glyphView.frame = CGRect(origin: glyphOrigin, size: glyphSize)
    }
    
    var glyphExclusionPath: UIBezierPath? {
        let glyph = glyphView.filledGlyph ?? glyphView.glyph
        if let glyphPath = UIGlyph(glyph).bezierPath {
            let t = CGAffineTransform(translationX: 0, y: -glyphTopOffset)
            glyphPath.apply(t)
            return glyphPath
        }
        return nil
    }
    
    // MARK: Subviews accessors (private)
    
    private var glyphView: GlyphView! {
        return view?.glyphView
    }
    
    private var textView: UITextView! {
        return view?.textView
    }
    
    // MARK: Layout sizes (private)
    
    private func contentHeight(forWidth fixedWidth: CGFloat) -> CGFloat {
        return textBodyHeight(forWidth: fixedWidth) + glyphTopOffset
    }
    
    private var textBodySize: CGSize {
        guard let superview = view.superview else {
            return textView.sizeThatFits(.zero)
        }
        let width = superview.frame.width
        let height = textBodyHeight(forWidth: width)
        return CGSize(width: width, height: height)
    }
    
    private func textBodyHeight(forWidth fixedWidth: CGFloat) -> CGFloat {
        let fitSize = CGSize(width: fixedWidth, height: .greatestFiniteMagnitude)
        let newSize = textView.sizeThatFits(fitSize)
        return newSize.height
    }
    
    private var glyphTopOffset: CGFloat {
        guard let glyph = glyphView.glyph else { return 0 }
        guard let attrText = textView.attributedText else { return 0 }
        return attrText.dropCapTopOffset(forGlyph: glyph)
    }
}
