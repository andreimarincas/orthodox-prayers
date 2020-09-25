//
//  RTFPrayerParser.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 11/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class RTFPrayerParser {
    let titleFont = UIFont(name: "Georgia", size: 24)!
    let subtitleFont = UIFont(name: "Georgia-BoldItalic", size: 15)!
    let normalFont = UIFont(name: "Georgia", size: 16.5)!
    let boldFont = UIFont(name: "Georgia-Bold", size: 16.5)!
    let commentFont = UIFont(name: "Georgia-Italic", size: 16.5)!
    let dropCapLetterFont = UIFont(name: "Arhaic", size: 60)!
    
    let paragraphSpacing: CGFloat = 22
    let minimumParagraphSpacing: CGFloat = 8
    
    let titleColor = UIColor.readingTextColor
    
    func parsePrayer(_ rtfPrayer: NSAttributedString) -> [NSAttributedString] {
        let prayer = updatePrayer(rtfPrayer: rtfPrayer)
        var lines = prayer.components(separatedBy: "\n")
        if !lines.isEmpty {
            lines[0] = stylizeTitle(lines[0])
        }
        adjustParagraphSpacing(&lines)
        return lines
    }
    
    // MARK: Private methods
    
    /// Updates the RTF prayer by replacing original attributes with custom attributes.
    private func updatePrayer(rtfPrayer: NSAttributedString) -> NSAttributedString {
        let newPrayer = rtfPrayer.mutableCopy() as! NSMutableAttributedString
        let range = NSRange(location: 0, length: newPrayer.length)
        let options: NSAttributedString.EnumerationOptions = [.longestEffectiveRangeNotRequired]
        newPrayer.enumerateAttributes(in: range, options: options) { (attrs, range, stop) in
            let newAttributes = updateAttributes(attrs)
            newPrayer.addAttributes(newAttributes, range: range)
        }
        return newPrayer
    }
    
    private func updateAttributes(_ attrs: [NSAttributedString.Key : Any]) -> [NSAttributedString.Key : Any] {
        var attributes = attrs
        updateFont(&attributes)
        updateTextColor(&attributes)
        updateParagraphStyle(&attributes)
        return attributes
    }
    
    private func updateFont(_ attributes: inout [NSAttributedString.Key : Any]) {
        guard let font = attributes[.font] as? UIFont else { return }
        if font.fontName == "TimesNewRomanPSMT" {
            attributes[.font] = normalFont
        } else if font.fontName == "TimesNewRomanPS-ItalicMT" { // comment
            attributes[.font] = commentFont
        } else if font.fontName == "TimesNewRomanPS-BoldMT" { // non-arhaic first letter
            attributes[.font] = boldFont
        } else if font.fontName == "TimesNewRomanPS-BoldItalicMT" { // subtitle
            attributes[.font] = subtitleFont
        } else if font.fontName == "Arhaic" { // drop cap letter
            attributes[.font] = dropCapLetterFont
        }
    }
    
    private func updateTextColor(_ attributes: inout [NSAttributedString.Key : Any]) {
        guard let textColor = attributes[.foregroundColor] as? UIColor else { return }
        if textColor.cgColor.components == UIColor.rtfTextColor.cgColor.components {
            attributes[.foregroundColor] = UIColor.readingTextColor
        } else if textColor.cgColor.components == UIColor.rtfTextHighlightColor.cgColor.components {
            attributes[.foregroundColor] = UIColor.readingTextHighlightColor
        }
    }
    
    private func updateParagraphStyle(_ attributes: inout [NSAttributedString.Key : Any]) {
        guard let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle else { return }
        let newParagraphStyle = paragraphStyle.mutableCopy() as! NSMutableParagraphStyle
        if paragraphStyle.paragraphSpacing > 0 {
            newParagraphStyle.paragraphSpacing = paragraphSpacing
        }
        if paragraphStyle.alignment != .center {
            newParagraphStyle.hyphenationFactor = 1
        }
        attributes[.paragraphStyle] = newParagraphStyle
    }
    
    private func stylizeTitle(_ title: NSAttributedString) -> NSAttributedString {
        let newTitle = title.mutableCopy() as! NSMutableAttributedString
        newTitle.addAttribute(.font, value: titleFont)
        newTitle.addAttribute(.foregroundColor, value: titleColor)
        newTitle.addParagraphSpacingBefore(paragraphSpacing)
        return newTitle
    }
    
    /// Adjust paragraph spacing for the drop cap letter
    private func adjustParagraphSpacing(_ lines: inout [NSAttributedString]) {
        for i in 1..<lines.count {
            guard lines[i].isFirstLetterArhaic else { continue }
            let dropCapTopOffset = lines[i].dropCapTopOffset
            let paragraphSpacing = lines[i - 1].paragraphSpacing.after
            let minParagraphSpacing: CGFloat = minimumParagraphSpacing
            let newParagraphSpacing = max(paragraphSpacing - dropCapTopOffset, minParagraphSpacing)
            if newParagraphSpacing != paragraphSpacing {
                lines[i - 1] = lines[i - 1].addingParagraphSpacing(newParagraphSpacing)
            }
        }
    }
}
