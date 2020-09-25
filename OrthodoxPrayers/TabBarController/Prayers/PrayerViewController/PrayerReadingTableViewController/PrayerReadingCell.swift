//
//  PrayerReadingCell.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 09/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerReadingCell: UIView {
    private var textView: DropCapTextView!
    private let textMargin: (left: CGFloat, right: CGFloat) = (left: 16, right: 16)
    
    var attributedString: NSAttributedString? {
        didSet {
            updateTextViewInset()
            updateAttributedText()
        }
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        textView = DropCapTextView()
        addSubview(textView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return textView.sizeThatFits(size)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textView.frame = CGRect(origin: .zero, size: frame.size)
    }
    
    // MARK: Private methods
    
    private func updateTextViewInset() {
        guard let attributedString = self.attributedString else {
            textView.textView.textContainerInset = .zero
            return
        }
        let paragraphSpacing = attributedString.paragraphSpacing
        var inset = UIEdgeInsets()
        inset.top = paragraphSpacing.before
        inset.bottom = paragraphSpacing.after
        inset.left = textMargin.left
        inset.right = textMargin.right
        textView.textView.textContainerInset = inset
    }
    
    private func updateAttributedText() {
        let isFirstLetterArhaic = attributedString?.isFirstLetterArhaic ?? false
        textView.setAttributedText(attributedString, dropCap: isFirstLetterArhaic)
    }
}
