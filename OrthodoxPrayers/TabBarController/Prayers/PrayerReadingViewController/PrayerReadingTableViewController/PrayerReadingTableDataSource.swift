//
//  PrayerReadingTableDataSource.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 11/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation
import CoreGraphics

class PrayerReadingTableDataSource {
    private let prayerItems: [NSAttributedString]
    let textSize = CGFloat(UserDefaults.standard.textSize)
    
    init(prayer: String, parent: String?, section: String) {
        let loader = RTFPrayerLoader()
        if let rtfPrayer = loader.loadPrayerFromRtf(fileNamed: prayer, parent: parent, section: section) {
            let defaultAttributes = PrayerReadingAttributes.default
            let attrs = defaultAttributes.scaledTo(normalFontSize: textSize)
            let parser = RTFPrayerParser(attributes: attrs)
            prayerItems = parser.parsePrayer(rtfPrayer)
        } else {
            logError("Failed to parse rtf prayer: \(prayer)")
            prayerItems = []
        }
    }
    
    var numberOfItems: Int {
        return prayerItems.count
    }
    
    func prayerItem(at index: Int) -> NSAttributedString {
        return prayerItems[index]
    }
}
