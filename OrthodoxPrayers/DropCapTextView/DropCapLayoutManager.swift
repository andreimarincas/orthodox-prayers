//
//  DropCapLayoutManager.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 08/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class DropCapLayoutManager {
    weak var view: DropCapTextView!
    
    private var needsLayoutUpdate = false
    private var textBodyHeightCache = [CGFloat: CGFloat]()
    
    init(view: DropCapTextView) {
        self.view = view
    }
    
    func sizeThatFits(_ size: CGSize) -> CGSize {
        let height = contentHeight(forWidth: size.width)
        return CGSize(width: size.width, height: height)
    }
    
    func layoutSubviews() {
        guard needsLayoutUpdate else { return }
        // Update body text frame
        let textBodyOrigin = CGPoint(x: 0, y: glyphTopOffset)
        textView.frame = CGRect(origin: textBodyOrigin, size: textBodySize)
        // Update glyph frame
        let glyphOrigin = CGPoint(x: textView.textContainerInset.left, y: textView.textContainerInset.top)
        let glyphSize = glyphView.sizeThatFits(.zero)
        glyphView.frame = CGRect(origin: glyphOrigin, size: glyphSize)
        // Turn off layout updates until new data
        needsLayoutUpdate = false
    }
    
    // Call this when view data changes
    func setNeedsLayout() {
        needsLayoutUpdate = true
        textBodyHeightCache.removeAll()
        view.setNeedsLayout()
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
    
    private func textBodyHeight(forWidth fixedWidth: CGFloat) -> CGFloat {
        if let cached = textBodyHeightCache[fixedWidth] {
            return cached
        }
        let fitSize = CGSize(width: fixedWidth, height: .greatestFiniteMagnitude)
        let newSize = textView.sizeThatFits(fitSize)
        textBodyHeightCache[fixedWidth] = newSize.height
        return newSize.height
    }
    
    private var textBodySize: CGSize {
        let height = textBodyHeight(forWidth: view.frame.width)
        return CGSize(width: view.frame.width, height: height)
    }
    
    private var glyphTopOffset: CGFloat {
        guard let glyph = glyphView.glyph else { return 0 }
        guard let attrText = textView.attributedText else { return 0 }
        return attrText.dropCapTopOffset(forGlyph: glyph)
    }
}
