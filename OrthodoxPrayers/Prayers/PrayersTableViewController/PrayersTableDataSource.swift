//
//  PrayersTableDataSource.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 26/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class PrayersTableDataSource: NSObject {
    private var sections = [String]()
    private var prayerItemsPerSection = [String: [String]]()
    
    override init() {
        let parser = PrayersContentsParser.shared
        self.sections = parser.parsePrayerSections()
        self.prayerItemsPerSection = parser.parsePrayerItemsPerSection()
        super.init()
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func numberOfPrayers(inSectionAt sectionIndex: Int) -> Int {
        let sectionTitle = sections[sectionIndex]
        let prayerItems = prayerItemsPerSection[sectionTitle]
        return prayerItems?.count ?? 0
    }
    
    func sectionTitle(forSectionAt sectionIndex: Int) -> String {
        return sections[sectionIndex]
    }
    
    func prayerItem(at index: Int, inSectionAt sectionIndex: Int) -> String {
        let sectionTitle = sections[sectionIndex]
        let prayerItems = prayerItemsPerSection[sectionTitle]
        return prayerItems?[index] ?? ""
    }
}
