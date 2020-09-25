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
    
    func components(separatedBy separator: String) -> [NSAttributedString] {
        var result = [NSAttributedString]()
        let separatedStrings = string.components(separatedBy: separator)
        var range = NSRange(location: 0, length: 0)
        for string in separatedStrings {
            range.length = string.utf16.count
            let attributedString = attributedSubstring(from: range)
            result.append(attributedString)
            range.location += range.length + separator.utf16.count
        }
        return result
    }
    
    func attribute(_ attrName: NSAttributedString.Key, at location: Int) -> Any? {
        guard location >= 0 && location < length else { return nil }
        return attribute(attrName, at: location, effectiveRange: nil)
    }
    
    var font: UIFont? {
        return attribute(.font, at: 0) as? UIFont
    }
    
    var isFirstLetterArhaic: Bool {
        return font?.isArhaic ?? false
    }
    
    var lineHeight: CGFloat {
        return font?.lineHeight ?? 0
    }
    
    var descender: CGFloat {
        return font?.descender ?? 0
    }
    
    var paragraphStyle: NSParagraphStyle? {
        return attribute(.paragraphStyle, at: 0) as? NSParagraphStyle
    }
    
    var isParagraph: Bool {
        guard let paragraphStyle = self.paragraphStyle else { return false }
        return paragraphStyle.alignment != .center // `center` is for title only
    }
    
    var paragraphSpacing: (before: CGFloat, after: CGFloat) {
        guard let paragraphStyle = self.paragraphStyle else { return (before: 0, after: 0) }
        return (before: paragraphStyle.paragraphSpacingBefore, after: paragraphStyle.paragraphSpacing)
    }
    
    func addingParagraphSpacing(_ paragraphSpacing: CGFloat) -> NSAttributedString {
        let mutableStr = mutableCopy() as! NSMutableAttributedString
        mutableStr.addParagraphSpacing(paragraphSpacing)
        return mutableStr
    }
    
    func addingFirstLineHeadIndent(_ firstLineHeadIndent: CGFloat) -> NSAttributedString {
        let mutableStr = mutableCopy() as! NSMutableAttributedString
        mutableStr.addFirstLineHeadIndent(firstLineHeadIndent)
        return mutableStr
    }
    
    // The drop cap top offset of the first letter in the text relative to the remaining text.
    var dropCapTopOffset: CGFloat {
        guard length > 1 else { return 0 } // must have a drop cap letter and some text
        let dropCapLetter = attributedSubstring(from: NSRange(location: 0, length: 1))
        guard let glyph = dropCapLetter.glyphs().first else { return 0 }
        let text = attributedSubstring(from: NSRange(location: 1, length: length - 1))
        return text.dropCapTopOffset(forGlyph: glyph)
    }
    
    // The drop cap offset for the given glyph relative to the text.
    // Discussion: Calculates how many lines fit in glyph's height and returns the remaining value + the font's descender value, so that the glyph takes as many lines as possible and the glyph's bottom line is aligned with the text.
    func dropCapTopOffset(forGlyph glyph: Glyph) -> CGFloat {
        let glyphHeight = glyph.bounds.height
        let lineHeight = self.lineHeight
        guard glyphHeight > lineHeight && lineHeight > 0 else { return 0 }
        let x = glyphHeight / lineHeight // this is how many lines the glyph takes (ex. 2.4)
        let f = x - CGFloat(Int(x))
        return f * lineHeight - descender
    }
}
