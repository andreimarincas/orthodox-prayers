//
//  FavouritePrayersDataSource.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 03/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class FavouritePrayersDataSource: PrayersDataSource {
    
    override init(parser: PrayersContentsParser = .shared) {
        super.init(parser: parser)
        var filteredSections = [String?]()
        var filteredAssociatedSections = [String]()
        var filteredPrayerItemsPerSection = [Int: [String]]()
        let favouritePrayers = Set(Prayer.favouritePrayers.map { $0.title })
        for sectionIndex in 0..<sections.count {
            let prayerItems = prayerItemsPerSection[sectionIndex]!
            let filteredPrayers = filterPrayerItems(prayerItems: prayerItems,
                                                    inSection: associatedSections[sectionIndex],
                                                    favouritePrayers: favouritePrayers, parser: parser)
            if !filteredPrayers.isEmpty {
                filteredSections.append(sections[sectionIndex])
                filteredAssociatedSections.append(associatedSections[sectionIndex])
                filteredPrayerItemsPerSection[filteredSections.count - 1] = filteredPrayers
            }
        }
        sections = filteredSections
        associatedSections = filteredAssociatedSections
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
