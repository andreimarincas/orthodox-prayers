//
//  FavouritePrayersDataSource.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 03/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class FavouritePrayersDataSource: PrayersTableDataSource {
    
    override init(parser: PrayersContentsParser) {
        super.init(parser: parser)
        var filteredSections = [String?]()
        var filteredPrayerItemsPerSection = [Int: [String]]()
        let favouritePrayers = Set(Prayer.favourites.map { $0.title })
        var section = ""
        for sectionIndex in 0..<sections.count {
            if let currentSection = sections[sectionIndex] {
                section = currentSection
            }
            let prayerItems = prayerItemsPerSection[sectionIndex]!
            let filteredPrayers = filterPrayerItems(prayerItems: prayerItems, inSection: section, favouritePrayers: favouritePrayers, parser: parser)
            if !filteredPrayers.isEmpty {
                if filteredSections.last == section {
                    filteredSections.append(sections[sectionIndex])
                } else {
                    filteredSections.append(section)
                }
                filteredPrayerItemsPerSection[filteredSections.count - 1] = filteredPrayers
            }
        }
        sections = filteredSections
        prayerItemsPerSection = filteredPrayerItemsPerSection
    }
    
    // MARK: Private methods
    
    private func filterPrayerItems(prayerItems: [String], inSection section: String, favouritePrayers: Set<String>, parser: PrayersContentsParser) -> [String] {
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
}
