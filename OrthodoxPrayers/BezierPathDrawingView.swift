//
//  BezierPathDrawingView.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 05/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

//import UIKit
//
//class BezierPathDrawingView: UIView {
//    var bezierPath: UIBezierPath?
//    var fillColor = UIColor.systemFill
//
//    init() {
//        super.init(frame: .zero)
//        backgroundColor = .clear
//        isOpaque = false
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override var intrinsicContentSize: CGSize {
//        guard let bezierPath = self.bezierPath else { return .zero }
//        return bezierPath.bounds.size
//    }
//
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        return intrinsicContentSize
//    }
//
//    override func draw(_ rect: CGRect) {
//        guard let bezierPath = self.bezierPath else { return }
//        fillColor.setFill()
//        bezierPath.fill()
//    }
//
//    func updateUI() {
//        sizeToFit()
//        setNeedsDisplay()
//    }
//}
