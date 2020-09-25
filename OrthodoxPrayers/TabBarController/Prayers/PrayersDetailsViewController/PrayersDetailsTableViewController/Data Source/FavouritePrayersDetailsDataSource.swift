//
//  FavouritePrayersDetailsDataSource.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 17/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class FavouritePrayersDetailsDataSource: PrayersDetailsDataSourceProtocol {
    let title: String
    private let prayerItems: [String]
    
    private init(title: String, prayerItems: [String]) {
        self.title = title
        self.prayerItems = prayerItems
    }
    
    convenience init(prayer: String, section: String, parser: PrayersContentsParser = .shared) {
        let parsedItems = parser.parsePrayerDetailedItems(forPrayer: prayer, inSection: section).filter { $0 != "" }
        let favouritePrayers = Set(Prayer.favouritePrayers.map { $0.title })
        let prayerItems = parsedItems.filter { favouritePrayers.contains($0) }
        self.init(title: prayer, prayerItems: prayerItems)
    }
    
    // MARK: PrayersDetailsDataSourceProtocol
    
    var numberOfSections: Int {
        return 1
    }
    
    var isEmpty: Bool {
        return !prayerItems.isEmpty
    }
    
    func numberOfPrayers(inSectionAt sectionIndex: Int) -> Int {
        assert(sectionIndex == 0)
        return prayerItems.count
    }
    
    func prayerItem(at index: Int, inSectionAt sectionIndex: Int) -> String {
        assert(sectionIndex == 0)
        return prayerItems[index]
    }
}
