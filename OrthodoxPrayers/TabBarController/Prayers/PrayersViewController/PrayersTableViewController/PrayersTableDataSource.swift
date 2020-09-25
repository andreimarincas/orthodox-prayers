//
//  PrayersTableDataSource.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 26/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

protocol PrayersTableDataSourceProtocol {
    var numberOfSections: Int { get }
    func title(forSectionAt sectionIndex: Int) -> String
    func numberOfPrayers(inSectionAt sectionIndex: Int) -> Int
    func prayerItem(at index: Int, inSectionAt sectionIndex: Int) -> String
}

class PrayersTableDataSource: PrayersTableDataSourceProtocol {
    var sections: [String]
    var prayerItemsPerSection: [String: [String]]
    
    init() {
        sections = []
        prayerItemsPerSection = [:]
    }
    
    init(parser: PrayersContentsParser) {
        sections = parser.parsePrayerSections()
        prayerItemsPerSection = parser.parsePrayerItemsPerSection()
    }
    
    var isEmpty: Bool {
        return sections.isEmpty
    }
    
    // MARK: Prayers Table Data Source Protocol
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func title(forSectionAt sectionIndex: Int) -> String {
        return sections[sectionIndex]
    }
    
    func numberOfPrayers(inSectionAt sectionIndex: Int) -> Int {
        let sectionTitle = sections[sectionIndex]
        let prayerItems = prayerItemsPerSection[sectionTitle]
        return prayerItems?.count ?? 0
    }
    
    func prayerItem(at index: Int, inSectionAt sectionIndex: Int) -> String {
        let sectionTitle = sections[sectionIndex]
        let prayerItems = prayerItemsPerSection[sectionTitle]
        return prayerItems?[index] ?? ""
    }
}
