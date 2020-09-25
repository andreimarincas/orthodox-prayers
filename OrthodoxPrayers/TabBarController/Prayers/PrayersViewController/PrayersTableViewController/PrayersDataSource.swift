//
//  PrayersDataSource.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 26/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class PrayersDataSource {
    let parser: PrayersContentsParser
    var sections: [String?]
    var associatedSections: [String]
    var prayerItemsPerSection: [Int: [String]]
    
    // MARK: Initialization
    
    init(parser: PrayersContentsParser = .shared) {
        self.parser = parser
        sections = [String?]()
        associatedSections = []
        prayerItemsPerSection = [Int: [String]]()
        let parsedSections = parser.parsePrayerSections()
        let parsedPrayerItemsPerSection = parser.parsePrayerItemsPerSection()
        for section in parsedSections {
            let prayerItems = parsedPrayerItemsPerSection[section]!
            let splitItems = splitPrayerItemsPerSection(prayerItems)
            var sectionOrNil: String? = section
            for items in splitItems {
                sections.append(sectionOrNil)
                associatedSections.append(section)
                prayerItemsPerSection[sections.count - 1] = items
                sectionOrNil = nil
            }
        }
    }
    
    // MARK: Private methods
    
    private func splitPrayerItemsPerSection(_ prayerItemsPerSection: [String]) -> [[String]] {
        var result = [[String]]()
        var array = [String]()
        for item in prayerItemsPerSection {
            if item.isEmpty {
                result.append(array)
                array = [String]()
            } else {
                array.append(item)
            }
        }
        result.append(array)
        return result
    }
    
    // MARK: Public methods
    
    var isEmpty: Bool {
        return sections.isEmpty
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func title(forSectionAt sectionIndex: Int) -> String? {
        return sections[sectionIndex]
    }
    
    func associatedSectionTitle(forSectionAt sectionIndex: Int) -> String {
        return associatedSections[sectionIndex]
    }
    
    func numberOfPrayers(inSectionAt sectionIndex: Int) -> Int {
        return prayerItemsPerSection[sectionIndex]!.count
    }
    
    func prayerItem(at index: Int, inSectionAt sectionIndex: Int) -> String {
        return prayerItemsPerSection[sectionIndex]![index]
    }
    
    func isDetailedItem(prayerItem: String, inSection sectionTitle: String) -> Bool {
        guard let isDetailedItem = parser.isDetailedItem(prayerItem: prayerItem, inSection: sectionTitle) else {
            logError("Couldn't find prayer: \(prayerItem) in section: \(sectionTitle)")
            return false
        }
        return isDetailedItem
    }
}
