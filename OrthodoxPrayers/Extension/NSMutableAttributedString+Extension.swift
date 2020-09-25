//
//  NSMutableAttributedString+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 10/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    func addAttribute(_ name: NSAttributedString.Key, value: Any) {
        guard length > 0 else { return }
        let range = NSRange(location: 0, length: length)
        addAttribute(name, value: value, range: range)
    }
    
    func addParagraphSpacingBefore(_ paragraphSpacingBefore: CGFloat) {
        let range = NSRange(location: 0, length: length)
        let options: NSAttributedString.EnumerationOptions = [.longestEffectiveRangeNotRequired]
        enumerateAttribute(.paragraphStyle, in: range, options: options) { (value, range, stop) in
            guard let paragraphStyle = value as? NSParagraphStyle else { return }
            let newParagraphStyle = paragraphStyle.mutableCopy() as! NSMutableParagraphStyle
            newParagraphStyle.paragraphSpacingBefore = paragraphSpacingBefore
            addAttribute(.paragraphStyle, value: newParagraphStyle, range: range)
        }
    }
    
    func addParagraphSpacing(_ paragraphSpacing: CGFloat) {
        let range = NSRange(location: 0, length: length)
        let options: NSAttributedString.EnumerationOptions = [.longestEffectiveRangeNotRequired]
        enumerateAttribute(.paragraphStyle, in: range, options: options) { (value, range, stop) in
            guard let paragraphStyle = value as? NSParagraphStyle else { return }
            let newParagraphStyle = paragraphStyle.mutableCopy() as! NSMutableParagraphStyle
            newParagraphStyle.paragraphSpacing = paragraphSpacing
            addAttribute(.paragraphStyle, value: newParagraphStyle, range: range)
        }
    }
    
    func addFirstLineHeadIndent(_ firstLineHeadIndent: CGFloat) {
        let range = NSRange(location: 0, length: length)
        let options: NSAttributedString.EnumerationOptions = [.longestEffectiveRangeNotRequired]
        enumerateAttribute(.paragraphStyle, in: range, options: options) { (value, range, stop) in
            guard let paragraphStyle = value as? NSParagraphStyle else { return }
            let newParagraphStyle = paragraphStyle.mutableCopy() as! NSMutableParagraphStyle
            newParagraphStyle.firstLineHeadIndent = firstLineHeadIndent
            addAttribute(.paragraphStyle, value: newParagraphStyle, range: range)
        }
    }
}
