//
//  TextViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 23/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    private var dropCapTextView: DropCapTextView!
    @IBOutlet weak var slider: UISlider!
    
    private let textMargin: CGFloat = 16
    
    let minBodyTextFontSize: CGFloat = 12
    let maxBodyTextFontSize: CGFloat = 28
    let defaultBodyTextFontSize: CGFloat = 16.5
    let defaultDropCapLetterFontSize: CGFloat = 60
    
    override func viewDidLoad() {
        let dropCapTextView = DropCapTextView()
        dropCapTextView.setAttributedText(attributedText, dropCap: true)
        view.addSubview(dropCapTextView)
        self.dropCapTextView = dropCapTextView
        
        let max = maxBodyTextFontSize
        let min = minBodyTextFontSize
        slider.value = Float(1 - (max - defaultBodyTextFontSize) / (max - min))
    }
    
    private lazy var dropCapLetterFont: UIFont = {
        return UIFont(name: "Arhaic", size: defaultDropCapLetterFontSize)!
    }()
    
    private lazy var bodyTextFont: UIFont = {
        return UIFont(name: "Georgia", size: defaultBodyTextFontSize)!
    }()
    
    private lazy var attributedText: NSMutableAttributedString = {
        let text = "Tatăl nostru, Care ești în ceruri, sfințească-Se numele Tău, vie împărăția Ta, facă-se voia Ta, precum în cer așa și pe pământ. Pâinea noastră cea de toate zilele, dă-ne-o nouă astăzi, și ne iartă nouă greșalele noastre, precum și noi iertăm greșiților noștri. Și nu ne duce pe noi în ispită, ci ne izbăvește de cel rău."
        
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
        attrText.addAttributes(dropCapLetterAttrs, range: NSRange(location: 0, length: 1))
        attrText.addAttributes(bodyAttrs, range: NSRange(location: 1, length: attrText.length - 1))
        return attrText
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let fitWidth = view.safeAreaSize.width - 2 * textMargin
        let fitSize = dropCapTextView.sizeThatFits(CGSize(width: fitWidth, height: -1))
        let posY = (view.safeAreaSize.height - fitSize.height) / 2
        dropCapTextView.frame = CGRect(x: textMargin, y: posY, width: fitWidth, height: fitSize.height)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        log("\(sender.value)")
        let min = minBodyTextFontSize
        let max = maxBodyTextFontSize
        let newBodyTextFontSize = min + CGFloat(slider.value) * (max - min)
        
        let r = defaultDropCapLetterFontSize / defaultBodyTextFontSize
        let newDropCapLetterFont = dropCapLetterFont.withSize(r * newBodyTextFontSize)
        let firstLetterRange = NSRange(location: 0, length: 1)
        attributedText.addAttribute(.font, value: newDropCapLetterFont, range: firstLetterRange)
        
        let newBodyTextFont = bodyTextFont.withSize(newBodyTextFontSize)
        let bodyTextRange = NSRange(location: 1, length: attributedText.length - 1)
        attributedText.addAttribute(.font, value: newBodyTextFont, range: bodyTextRange)
        
        dropCapTextView.setAttributedText(attributedText, dropCap: true)
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}
