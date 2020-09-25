//
//  PrayersDetailsTableDataSource.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 29/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class PrayersDetailsTableDataSource: NSObject {
    private var detailedPrayer: String?
    private var detailedPrayerItems = [String]()
    
    init(prayer: String, section: String) {
        let parser = PrayersContentsParser.shared
        self.detailedPrayerItems = parser.parsePrayerDetailedItems(forPrayer: prayer, inSection: section)
        super.init()
    }
    
    var prayer: String {
        return detailedPrayer ?? ""
    }
    
    var numberOfPrayers: Int {
        return detailedPrayerItems.count
    }
    
    func prayerItem(at index: Int) -> String {
        return detailedPrayerItems[index]
    }
}
