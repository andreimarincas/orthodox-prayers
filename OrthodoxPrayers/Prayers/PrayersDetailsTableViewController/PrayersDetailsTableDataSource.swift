//
//  PrayersDetailsTableDataSource.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 29/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class PrayersDetailsTableDataSource {
    let title: String
    private let prayerItems: [String]
    
    init(title: String, prayerItems: [String]) {
        self.title = title
        self.prayerItems = prayerItems
    }
    
    convenience init(prayer: String, section: String, favouritesOnly: Bool) {
        let parser = PrayersContentsParser.shared
        var prayerItems = parser.parsePrayerDetailedItems(forPrayer: prayer, inSection: section)
        if favouritesOnly {
            let favouritePrayers = Set(Prayer.favourites.map { $0.title })
            prayerItems = prayerItems.filter { favouritePrayers.contains($0) }
        }
        self.init(title: prayer, prayerItems: prayerItems)
    }
    
    var numberOfPrayers: Int {
        return prayerItems.count
    }
    
    func prayerItem(at index: Int) -> String {
        return prayerItems[index]
    }
}
