//
//  UIColor+Assets.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 09/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

extension UIColor {
    static let activeColor = UIColor(named: "activeColor")!
    static let favouritesBackgroundColor = UIColor(named: "favouritesBackgroundColor")!
    static let favouritesSelectedColor = UIColor(named: "favouritesSelectedColor")!
    static let favouritesTextColor = UIColor(named: "favouritesTextColor")!
    static let mainBackgroundColor = UIColor(named: "mainBackgroundColor")!
    static let navigationBarTintColor = UIColor(named: "navigationBarTintColor")!
    static let noFavouritesTextColor = UIColor(named: "noFavouritesTextColor")!
    static let prayerCellBackgroundColor = UIColor(named: "prayerCellBackgroundColor")!
    static let prayerCellSelectedColor = UIColor(named: "prayerCellSelectedColor")!
    static let prayerCellTextColor = UIColor(named: "prayerCellTextColor")!
    static let prayerHeaderTextColor = UIColor(named: "prayerHeaderTextColor")!
    static let readingBackgroundColor = UIColor(named: "readingBackgroundColor")!
    static let readingTextColor = UIColor(named: "readingTextColor")!
    static let readingTextHighlightColor = UIColor(named: "readingTextHighlightColor")!
    static let tabBarItemUnselectedColor = UIColor(named: "tabBarItemUnselectedColor")!
    static let sliderLabelColor = UIColor(named: "sliderLabelColor")!
    
//    static let rtfTextColor = UIColor(red: 0.13725, green: 0.12157, blue: 0.12549, alpha: 1)
//    static let rtfTextHighlightColor = UIColor(red: 0.92549, green: 0, blue: 0.54902, alpha: 1)
    
//    var luminance: CGFloat {
//        var red: CGFloat = 0
//        var green: CGFloat = 0
//        var blue: CGFloat = 0
//        getRed(&red, green: &green, blue: &blue, alpha: nil)
//        return 0.2126 * red + 0.7152 * green + 0.0722 * blue
//    }
    
//    var isLight: Bool {
//        return luminance > 0.7
//    }
    
    var redValue: CGFloat {
        var red: CGFloat = 0
        getRed(&red, green: nil, blue: nil, alpha: nil)
        return red
    }
}
