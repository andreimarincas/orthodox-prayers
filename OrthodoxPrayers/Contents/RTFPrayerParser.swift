//
//  RTFPrayerParser.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 11/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class RTFPrayerParser {
    let prayerReadingAttributes: PrayerReadingAttributes
    
    init(attributes: PrayerReadingAttributes = .default) {
        self.prayerReadingAttributes = attributes
    }
    
    func parsePrayer(_ rtfPrayer: NSAttributedString) -> [NSAttributedString] {
        let prayer = updatePrayer(rtfPrayer: rtfPrayer)
        var lines = prayer.components(separatedBy: "\n")
        adjustParagraphSpacing(&lines)
        return groupByDropCap(lines)
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
            attributes[.font] = prayerReadingAttributes.normalFont
        } else if font.fontName == "TimesNewRomanPS-ItalicMT" { // comment
            attributes[.font] = prayerReadingAttributes.commentFont
        } else if font.fontName == "TimesNewRomanPS-BoldMT" { // title (all caps) OR non-arhaic first letter (capital)
            attributes[.font] = prayerReadingAttributes.boldFont
        } else if font.fontName == "TimesNewRomanPS-BoldItalicMT" { // subtitle
            attributes[.font] = prayerReadingAttributes.subtitleFont
        } else if font.fontName == "Arhaic" { // drop cap letter
            attributes[.font] = prayerReadingAttributes.dropCapLetterFont
        }
    }
    
    private func updateTextColor(_ attributes: inout [NSAttributedString.Key : Any]) {
        guard let textColor = attributes[.foregroundColor] as? UIColor else { return }
//        if textColor.cgColor.components == UIColor.rtfTextColor.cgColor.components {
//            attributes[.foregroundColor] = UIColor.readingTextColor
//        } else if textColor.cgColor.components == UIColor.rtfTextHighlightColor.cgColor.components {
//            attributes[.foregroundColor] = UIColor.readingTextHighlightColor
//        }
        log("red: \(textColor.redValue)")
        if textColor.redValue < 0.5 {
            attributes[.foregroundColor] = UIColor.readingTextColor
        } else {
            attributes[.foregroundColor] = UIColor.readingTextHighlightColor
        }
    }
    
    private func updateParagraphStyle(_ attributes: inout [NSAttributedString.Key : Any]) {
        guard let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle else { return }
        let newParagraphStyle = paragraphStyle.mutableCopy() as! NSMutableParagraphStyle
        if paragraphStyle.paragraphSpacing > 0 {
            newParagraphStyle.paragraphSpacing = prayerReadingAttributes.paragraphSpacing
        }
        if paragraphStyle.alignment != .center {
            newParagraphStyle.hyphenationFactor = prayerReadingAttributes.hyphenationFactor
        }
        attributes[.paragraphStyle] = newParagraphStyle
    }
    
    private func adjustParagraphSpacing(_ lines: inout [NSAttributedString]) {
        guard !lines.isEmpty else { return }
        // Add paragraph spacing before title
        lines[0] = lines[0].addingParagraphSpacingBefore(prayerReadingAttributes.paragraphSpacing)
        for i in 1..<lines.count {
            if lines[i].isFirstLetterArhaic {
                // Adjust paragraph spacing for the drop cap letter
                let dropCapTopOffset = lines[i].dropCapTopOffset
                let paragraphSpacing = lines[i - 1].paragraphSpacing.after
                let minParagraphSpacing: CGFloat = prayerReadingAttributes.minimumParagraphSpacing
                let newParagraphSpacing = max(paragraphSpacing - dropCapTopOffset, minParagraphSpacing)
                if newParagraphSpacing != paragraphSpacing {
                    lines[i - 1] = lines[i - 1].addingParagraphSpacing(newParagraphSpacing)
                }
            } else if lines[i].isParagraph {
                lines[i] = lines[i].addingFirstLineHeadIndent(prayerReadingAttributes.firstLineHeadIndent)
            }
        }
    }
    
    private func groupByDropCap(_ lines: [NSAttributedString]) -> [NSAttributedString] {
        var result = [NSAttributedString]()
        var composedString = NSMutableAttributedString()
        for line in lines {
            if line.isFirstLetterArhaic {
                if composedString.length > 0 {
                    result.append(composedString)
                }
                composedString = NSMutableAttributedString(attributedString: line)
            } else {
                if composedString.length > 0 {
                    composedString.append(NSAttributedString(string: "\n"))
                }
                composedString.append(line)
            }
        }
        if composedString.length > 0 {
            result.append(composedString)
        }
        return result
    }
}
