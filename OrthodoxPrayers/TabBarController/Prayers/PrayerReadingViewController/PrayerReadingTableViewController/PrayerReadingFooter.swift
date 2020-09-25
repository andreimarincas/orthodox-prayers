//
//  PrayerReadingFooter.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 11/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerReadingFooter: UIView {
    private var imageView: UIImageView!
    private let bottomMargin: CGFloat = 22
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        let divider = UIImage(named: "olivetreeDivider")!
        imageView = UIImageView(image: divider)
        imageView.contentMode = .center
        imageView.backgroundColor = .clear
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let imageSize = imageView.sizeThatFits(size)
        return CGSize(width: imageSize.width, height: imageSize.height + bottomMargin)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.sizeToFit()
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: imageView.frame.height)
    }
}
