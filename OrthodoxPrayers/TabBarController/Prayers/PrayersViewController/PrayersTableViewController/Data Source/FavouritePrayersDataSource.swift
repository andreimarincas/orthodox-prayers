//
//  FavouritePrayersDataSource.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 03/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class FavouritePrayersDataSource: PrayersDataSourceProtocol {
    private let parser: PrayersContentsParser
    private let sections: [String]
    private let prayerItemsPerSection: [Int: [String]]
    
    // MARK: Initialization
    
    private init(sections: [String], prayerItemsPerSection: [Int: [String]], parser: PrayersContentsParser) {
        self.sections = sections
        self.prayerItemsPerSection = prayerItemsPerSection
        self.parser = parser
    }
    
    convenience init(parser: PrayersContentsParser = .shared) {
        let parsedSections = parser.parsePrayerSections()
        let parsedPrayerItemsPerSection = parser.parsePrayerItemsPerSection()
        var filteredSections = [String]()
        var filteredPrayerItemsPerSection = [Int: [String]]()
        let favouritePrayers = Set(Prayer.favouritePrayers.map { $0.title })
        for sectionTitle in parsedSections {
            let prayerItems = parsedPrayerItemsPerSection[sectionTitle] ?? []
            let filteredPrayers = FavouritePrayersDataSource.filterPrayerItems(prayerItems: prayerItems, inSection: sectionTitle, favouritePrayers: favouritePrayers, parser: parser)
            if !filteredPrayers.isEmpty {
                filteredSections.append(sectionTitle)
                filteredPrayerItemsPerSection[filteredSections.count - 1] = filteredPrayers
            }
        }
        self.init(sections: filteredSections, prayerItemsPerSection: filteredPrayerItemsPerSection, parser: parser)
    }
    
    private static func filterPrayerItems(prayerItems: [String], inSection section: String, favouritePrayers: Set<String>, parser: PrayersContentsParser) -> [String] {
        var filteredPrayers = [String]()
        for prayerItem in prayerItems {
            if favouritePrayers.contains(prayerItem) {
                filteredPrayers.append(prayerItem)
                continue
            }
            let isDetailed = parser.isDetailedItem(prayerItem: prayerItem, inSection: section)
            if let detailed = isDetailed, detailed {
                let detailedItems = parser.parsePrayerDetailedItems(forPrayer: prayerItem, inSection: section)
                let firstFavouriteDetailedItem = detailedItems.first(where: { favouritePrayers.contains($0) })
                if firstFavouriteDetailedItem != nil {
                    filteredPrayers.append(prayerItem)
                }
            }
        }
        return filteredPrayers
    }
    
    // MARK: PrayersDataSourceProtocol
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func title(forSectionAt sectionIndex: Int) -> String? {
        return sections[sectionIndex]
    }
    
    func associatedTitle(forSectionAt sectionIndex: Int) -> String {
        return sections[sectionIndex]
    }
    
    func numberOfPrayers(inSectionAt sectionIndex: Int) -> Int {
        return prayerItemsPerSection[sectionIndex]!.count
    }
    
    func prayerItem(at index: Int, inSectionAt sectionIndex: Int) -> String {
        return prayerItemsPerSection[sectionIndex]![index]
    }
    
    func hasPrayersDetails(forPrayerItemAt prayerIndex: Int, inSectionAt sectionIndex: Int) -> Bool {
        let prayerItem = prayerItemsPerSection[sectionIndex]![prayerIndex]
        let sectionTitle = sections[sectionIndex]
        return parser.isDetailedItem(prayerItem: prayerItem, inSection: sectionTitle) ?? false
    }
}
