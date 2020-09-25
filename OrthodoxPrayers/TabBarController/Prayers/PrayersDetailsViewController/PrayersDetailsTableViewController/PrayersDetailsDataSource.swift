//
//  PrayersDetailsDataSource.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 29/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class PrayersDetailsDataSource {
    var prayerTitle: String
    var prayerItems: [String]
    
    init(prayer: String, section: String, parser: PrayersContentsParser = .shared) {
        prayerTitle = prayer
        prayerItems = parser.parsePrayerDetailedItems(forPrayer: prayer, inSection: section)
    }
    
    var isEmpty: Bool {
        return prayerItems.isEmpty
    }
    
    var numberOfPrayers: Int {
        return prayerItems.count
    }
    
    func prayerItem(at index: Int) -> String {
        return prayerItems[index]
    }
}
