//
//  PrayerReadingCell.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 09/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerReadingCell: UITableViewCell {
    static let reuseID = "prayerReadingCell"
    
    private var prayerTextView: PrayerTextView!
    
    private let textInsetLeft: CGFloat = 16
    private let textInsetRight: CGFloat = 16
    private let firstLineHeadIndent: CGFloat = 20
    
    var attributedString: NSAttributedString? {
        didSet {
            updateTextInset()
            updateText()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prayerTextView = PrayerTextView()
        prayerTextView.backgroundColor = .clear
        contentView.addSubviewAligned(prayerTextView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        attributedString = nil
    }
    
    // MARK: Private methods
    
    private func updateTextInset() {
        guard let attributedString = self.attributedString else {
            prayerTextView.textView.textContainerInset = .zero
            return
        }
        let paragraphSpacing = attributedString.paragraphSpacing
        var inset = UIEdgeInsets()
        inset.top = paragraphSpacing.before
        inset.bottom = paragraphSpacing.after
        inset.left = textInsetLeft
        inset.right = textInsetRight
        prayerTextView.textView.textContainerInset = inset
    }
    
    private func updateText() {
        guard let attributedString = self.attributedString else {
            prayerTextView.setAttributedText(nil, dropCap: false)
            return
        }
        if attributedString.isFirstLetterArhaic {
            prayerTextView.setAttributedText(attributedString, dropCap: true)
        } else {
            let firstLineHeadIndent = attributedString.isParagraph ? self.firstLineHeadIndent : 0
            let newAttrStr = attributedString.addingFirstLineHeadIndent(firstLineHeadIndent)
            prayerTextView.setAttributedText(newAttrStr, dropCap: false)
        }
    }
}
