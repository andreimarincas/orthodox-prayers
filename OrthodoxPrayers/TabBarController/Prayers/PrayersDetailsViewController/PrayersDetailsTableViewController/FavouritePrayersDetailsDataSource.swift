//
//  FavouritePrayersDetailsDataSource.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 17/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class FavouritePrayersDetailsDataSource: PrayersDetailsDataSource {
    override init(prayer: String, section: String, parser: PrayersContentsParser = .shared) {
        super.init(prayer: prayer, section: section, parser: parser)
        let favouritePrayers = Set(Prayer.favouritePrayers.map { $0.title })
        prayerItems = prayerItems.filter { favouritePrayers.contains($0) }
    }
}
