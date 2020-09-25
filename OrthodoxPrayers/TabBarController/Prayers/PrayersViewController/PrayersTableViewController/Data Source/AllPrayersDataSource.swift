//
//  AllPrayersDataSource.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 26/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class AllPrayersDataSource: PrayersDataSourceProtocol {
    private struct Section {
        var title: String?
        var associatedTitle: String
    }
    private let parser: PrayersContentsParser
    private let sections: [Section]
    private let prayerItemsPerSection: [Int: [String]]
    
    // MARK: Initialization
    
    private init(sections: [Section], prayerItemsPerSection: [Int: [String]], parser: PrayersContentsParser) {
        self.sections = sections
        self.prayerItemsPerSection = prayerItemsPerSection
        self.parser = parser
    }
    
    convenience init(parser: PrayersContentsParser = .shared) {
        let parsedSections = parser.parsePrayerSections()
        let parsedPrayerItemsPerSection = parser.parsePrayerItemsPerSection()
        var sections = [Section]()
        var prayerItemsPerSection = [Int: [String]]()
        for sectionTitle in parsedSections {
            let prayerItems = parsedPrayerItemsPerSection[sectionTitle] ?? []
            let splitItems = AllPrayersDataSource.splitPrayerItemsPerSection(prayerItems)
            var sectionTitleOrNil: String? = sectionTitle
            for items in splitItems {
                let section = Section(title: sectionTitleOrNil, associatedTitle: sectionTitle)
                sections.append(section)
                prayerItemsPerSection[sections.count - 1] = items
                sectionTitleOrNil = nil
            }
        }
        self.init(sections: sections, prayerItemsPerSection: prayerItemsPerSection, parser: parser)
    }
    
    private static func splitPrayerItemsPerSection(_ prayerItemsPerSection: [String]) -> [[String]] {
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
    
    // MARK: PrayersDataSourceProtocol
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func title(forSectionAt sectionIndex: Int) -> String? {
        return sections[sectionIndex].title
    }
    
    func associatedTitle(forSectionAt sectionIndex: Int) -> String {
        return sections[sectionIndex].associatedTitle
    }
    
    func numberOfPrayers(inSectionAt sectionIndex: Int) -> Int {
        return prayerItemsPerSection[sectionIndex]!.count
    }
    
    func prayerItem(at index: Int, inSectionAt sectionIndex: Int) -> String {
        return prayerItemsPerSection[sectionIndex]![index]
    }
    
    func hasPrayersDetails(forPrayerItemAt prayerIndex: Int, inSectionAt sectionIndex: Int) -> Bool {
        let prayerItem = prayerItemsPerSection[sectionIndex]![prayerIndex]
        let sectionTitle = sections[sectionIndex].associatedTitle
        return parser.isDetailedItem(prayerItem: prayerItem, inSection: sectionTitle) ?? false
    }
}
