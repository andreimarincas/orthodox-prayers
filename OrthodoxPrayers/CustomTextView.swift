//
//  CustomTextView.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 04/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

/*import UIKit

class CustomTextView: UIView {
    var text: String?
    var font = UIFont.systemFont(ofSize: 17)
    var textColor = UIColor.label

    var attributedText: NSAttributedString? {
        guard let text = self.text else { return nil }
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: textColor]
        return NSAttributedString(string: text, attributes: attributes)
    }

    var bezierPath: UIBezierPath? {
        guard let attributedText = self.attributedText else { return nil }
        return attributedText.bezierPath
    }

    //private let drawingView = BezierPathDrawingView()

    init() {
        super.init(frame: .zero)
        //addSubview(drawingView)
        backgroundColor = .clear
        isOpaque = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        guard let bezierPath = self.bezierPath else { return .zero }
        return bezierPath.bounds.size
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return intrinsicContentSize
    }

//    func updateUI() {
//        drawingView.fillColor = textColor
//        drawingView.bezierPath = bezierPath
//        drawingView.updateUI()
//        sizeToFit()
//        setNeedsDisplay()
//        drawingView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
//    }

    override func draw(_ rect: CGRect) {
        guard let bezierPath = self.bezierPath else { return }
        textColor.setFill()
        bezierPath.fill()
    }

    /*override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let bezierPath = self.bezierPath else { return .zero }
        //return bezierPath.bounds.size
        let bezierBounds = bezierPath.bounds
//        log("bezierBounds: \(bezierBounds)")
//        return CGSize(width: bezierBounds.origin.x + bezierBounds.width,
//                      height: bezierBounds.origin.y + bezierBounds.height)
    }*/
}*/
