//
//  PrayerReadingTableDataSource.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 11/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class PrayerReadingTableDataSource {
    private let prayerItems: [NSAttributedString]
    
    init(prayer: String, parent: String?, section: String) {
        let loader = RTFPrayerLoader()
        if let rtfPrayer = loader.loadPrayerFromRtf(fileNamed: prayer, parent: parent, section: section) {
            let parser = RTFPrayerParser()
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
