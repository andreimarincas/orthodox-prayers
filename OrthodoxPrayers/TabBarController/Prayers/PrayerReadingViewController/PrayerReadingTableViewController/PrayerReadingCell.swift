//
//  PrayerReadingCell.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 09/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerReadingCell: UIView {
    private(set) var dropCapTextView: DropCapTextView!
    private let textMargin: CGFloat = 16
    
    var attributedString: NSAttributedString? {
        didSet {
            updateTextViewInset()
            updateAttributedText()
        }
    }
    
    convenience init() {
        self.init(frame: .zero)
        backgroundColor = .clear
        dropCapTextView = DropCapTextView()
        addSubview(dropCapTextView)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return dropCapTextView.sizeThatFits(size)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dropCapTextView.frame = CGRect(origin: .zero, size: frame.size)
    }
    
    // MARK: Private methods
    
    private func updateTextViewInset() {
        guard let attributedString = self.attributedString else {
            dropCapTextView.textView.textContainerInset = .zero
            return
        }
        let paragraphSpacing = attributedString.paragraphSpacing
        var inset = UIEdgeInsets()
        inset.top = paragraphSpacing.before
        inset.bottom = paragraphSpacing.after
        inset.left = textMargin
        inset.right = textMargin
        dropCapTextView.textView.textContainerInset = inset
    }
    
    private func updateAttributedText() {
        let isFirstLetterArhaic = attributedString?.isFirstLetterArhaic ?? false
        dropCapTextView.setAttributedText(attributedString, dropCap: isFirstLetterArhaic)
    }
}
