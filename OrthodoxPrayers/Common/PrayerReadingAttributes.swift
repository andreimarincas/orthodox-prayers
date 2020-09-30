//
//  PrayerReadingAttributes.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 27/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

struct PrayerReadingAttributes {
    static let `default` = PrayerReadingAttributes()
    
    var subtitleFont = UIFont(name: "Georgia-BoldItalic", size: 15)!
    var normalFont = UIFont(name: "Georgia", size: 16.5)!
    var boldFont = UIFont(name: "Georgia-Bold", size: 16.5)!
    var commentFont = UIFont(name: "Georgia-Italic", size: 16.5)!
    var dropCapLetterFont = UIFont(name: "Arhaic", size: 60)!
    
    var paragraphSpacing: CGFloat = 22
    var minimumParagraphSpacing: CGFloat = 8
    var hyphenationFactor: Float = 0.9
    var firstLineHeadIndent: CGFloat = 20
    
    func scaledTo(normalFontSize newPointSize: CGFloat) -> PrayerReadingAttributes {
        guard newPointSize != normalFont.pointSize else { return self }
        let factor = newPointSize / normalFont.pointSize
        var attrs = self
        attrs.subtitleFont = subtitleFont.scaledBy(factor: factor)
        attrs.normalFont = normalFont.withSize(newPointSize)
        attrs.boldFont = boldFont.scaledBy(factor: factor)
        attrs.commentFont = commentFont.scaledBy(factor: factor)
        attrs.dropCapLetterFont = dropCapLetterFont.scaledBy(factor: factor)
        attrs.paragraphSpacing = factor * paragraphSpacing
        attrs.minimumParagraphSpacing = factor * minimumParagraphSpacing
        return attrs
    }
}
