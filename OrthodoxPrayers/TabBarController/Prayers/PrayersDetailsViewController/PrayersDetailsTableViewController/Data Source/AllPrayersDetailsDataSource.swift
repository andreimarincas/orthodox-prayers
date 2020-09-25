//
//  AllPrayersDetailsDataSource.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 29/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class AllPrayersDetailsDataSource: PrayersDetailsDataSourceProtocol {
    let title: String
    let numberOfSections: Int
    private let prayerItemsPerSection: [Int: [String]]
    
    private init(title: String, numberOfSections: Int, prayerItemsPerSection: [Int: [String]]) {
        self.title = title
        self.numberOfSections = numberOfSections
        self.prayerItemsPerSection = prayerItemsPerSection
    }
    
    convenience init(prayer: String, section: String, parser: PrayersContentsParser = .shared) {
        let parsedItems = parser.parsePrayerDetailedItems(forPrayer: prayer, inSection: section)
        var prayerItemsPerSection = [Int: [String]]()
        var numberOfSections: Int = 0
        var items = [String]()
        for prayerItem in parsedItems {
            if prayerItem == "" {
                prayerItemsPerSection[numberOfSections] = items
                numberOfSections += 1
                items = []
            } else {
                items.append(prayerItem)
            }
        }
        if !items.isEmpty {
            prayerItemsPerSection[numberOfSections] = items
            numberOfSections += 1
        }
        self.init(title: prayer, numberOfSections: numberOfSections, prayerItemsPerSection: prayerItemsPerSection)
    }
    
    // MARK: PrayersDetailsDataSourceProtocol
    
    var isEmpty: Bool {
        return numberOfSections > 0
    }
    
    func numberOfPrayers(inSectionAt sectionIndex: Int) -> Int {
        return prayerItemsPerSection[sectionIndex]!.count
    }
    
    func prayerItem(at index: Int, inSectionAt sectionIndex: Int) -> String {
        return prayerItemsPerSection[sectionIndex]![index]
    }
}
