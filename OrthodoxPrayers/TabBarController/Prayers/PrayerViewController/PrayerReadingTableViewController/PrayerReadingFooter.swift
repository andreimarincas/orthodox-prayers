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
//    private let padding: UI
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        let divider = UIImage(named: "olivetreeDivider")!
        imageView = UIImageView(image: divider)
        imageView.contentMode = .top
        imageView.backgroundColor = .clear
        addSubviewAligned(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
