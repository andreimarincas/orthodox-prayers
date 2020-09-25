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
        var filteredSections = [String]()
        var filteredPrayerItemsPerSection = [String: [String]]()
        let favouritePrayers = Set(Prayer.favourites.map { $0.title })
        for section in sections {
            let prayerItems = prayerItemsPerSection[section] ?? []
            let filteredPrayers = filterPrayerItems(prayerItems: prayerItems, inSection: section, favouritePrayers: favouritePrayers, parser: parser)
            if !filteredPrayers.isEmpty {
                filteredSections.append(section)
                filteredPrayerItemsPerSection[section] = filteredPrayers
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
