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
    func title(forSectionAt sectionIndex: Int) -> String?
    func associatedSectionTitle(forSectionAt sectionIndex: Int) -> String
    func numberOfPrayers(inSectionAt sectionIndex: Int) -> Int
    func prayerItem(at index: Int, inSectionAt sectionIndex: Int) -> String
}

class PrayersTableDataSource: PrayersTableDataSourceProtocol {
    var sections: [String?]!
    var prayerItemsPerSection: [Int: [String]]!
    
    // MARK: Initialization
    
    init() {
        sections = []
        prayerItemsPerSection = [:]
    }
    
    init(parser: PrayersContentsParser) {
        let parsedSections = parser.parsePrayerSections()
        let parsedPrayerItemsPerSection = parser.parsePrayerItemsPerSection()
        var sections = [String?]()
        var prayerItemsPerSection = [Int: [String]]()
        for parsedSection in parsedSections {
            let parsedItems = parsedPrayerItemsPerSection[parsedSection]!
            let splitItems = splitPrayerItemsPerSection(parsedItems)
            var section: String? = parsedSection
            for items in splitItems {
                sections.append(section)
                let sectionIndex = sections.count - 1
                prayerItemsPerSection[sectionIndex] = items
                section = nil
            }
        }
        self.sections = sections
        self.prayerItemsPerSection = prayerItemsPerSection
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
    
    var isEmpty: Bool {
        return sections.isEmpty
    }
    
    // MARK: Prayers Table Data Source Protocol
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func title(forSectionAt sectionIndex: Int) -> String? {
        return sections[sectionIndex]
    }
    
    /// Returns the first non-empty section title by going up.
    func associatedSectionTitle(forSectionAt sectionIndex: Int) -> String {
        var associatedSection = ""
        var index = sectionIndex
        while associatedSection.isEmpty && index >= 0 {
            if let section = sections[index] {
                associatedSection = section
            }
            index -= 1
        }
        return associatedSection
    }
    
    func numberOfPrayers(inSectionAt sectionIndex: Int) -> Int {
        return prayerItemsPerSection[sectionIndex]!.count
    }
    
    func prayerItem(at index: Int, inSectionAt sectionIndex: Int) -> String {
        return prayerItemsPerSection[sectionIndex]![index]
    }
}
