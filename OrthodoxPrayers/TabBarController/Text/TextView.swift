//
//  TextView.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 25/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class TextView: UIView {
    var dropCapLetterFont = UIFont.boldSystemFont(ofSize: 60)
    var bodyTextFont = UIFont.systemFont(ofSize: 17)
    
    var text: String = "" {
        didSet {
            updateAttributedText()
        }
    }
    
    func updateFontSize(dropCapSize newDropCapSize: CGFloat, bodyTextSize newBodyTextSize: CGFloat) {
        dropCapLetterFont = dropCapLetterFont.withSize(newDropCapSize)
        bodyTextFont = bodyTextFont.withSize(newBodyTextSize)
        updateAttributedText()
    }
    
    private func updateAttributedText() {
        let attrText = makeAttributedText()
        dropCapTextView.setAttributedText(attrText, dropCap: true)
        invalidateIntrinsicContentSize()
    }
    
    private lazy var dropCapTextView: DropCapTextView! = {
        let dropCapTextView = DropCapTextView()
        addSubviewAligned(dropCapTextView)
        setNeedsLayout()
        return dropCapTextView
    }()
    
    private func makeAttributedText() -> NSAttributedString {
        let dropCapLetterAttrs: [NSAttributedString.Key : Any] =
            [.font: dropCapLetterFont,
             .foregroundColor: UIColor.readingTextHighlightColor]
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        paragraphStyle.hyphenationFactor = 0.9
        
        let bodyAttrs: [NSAttributedString.Key : Any] =
            [.font: bodyTextFont,
             .foregroundColor: UIColor.readingTextColor,
             .paragraphStyle: paragraphStyle]
        
        let attrText = NSMutableAttributedString(string: text)
        let firstLetterRange = NSRange(location: 0, length: 1)
        let bodyTextRange = NSRange(location: 1, length: attrText.length - 1)
        attrText.addAttributes(dropCapLetterAttrs, range: firstLetterRange)
        attrText.addAttributes(bodyAttrs, range: bodyTextRange)
        return attrText
    }
    
    override var intrinsicContentSize: CGSize {
        guard let container = superview else { return UIView.noIntrinsicSize }
        let sizeToFit = container.frame.size
        return dropCapTextView.sizeThatFits(sizeToFit)
    }
}
