//
//  Prayer.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 02/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class Prayer {
    private let managedPrayer: ManagedPrayerItem
    
    var title: String {
        return managedPrayer.title
    }
    
    var isFavourite: Bool {
        get {
            return managedPrayer.isFavourite
        }
        set {
            managedPrayer.isFavourite = newValue
            PrayersDataProvider.shared.saveContext()
        }
    }
    
    init(managedPrayer: ManagedPrayerItem) {
        self.managedPrayer = managedPrayer
    }
    
    convenience init?(title: String) {
        let context = PrayersDataProvider.shared.context
        guard let managedPrayer = ManagedPrayerItem.fetchPrayer(withTitle: title, from: context) else {
            logError("Failed to fetch managed prayer item with title: \(title)")
            return nil
        }
        self.init(managedPrayer: managedPrayer)
    }
    
    static var favourites: [Prayer] {
        let context = PrayersDataProvider.shared.context
        let managedPrayers = ManagedPrayerItem.fetchFavourites(from: context) ?? []
        return managedPrayers.map { Prayer(managedPrayer: $0) }
    }
}
