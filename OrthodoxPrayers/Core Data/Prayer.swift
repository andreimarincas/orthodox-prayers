//
//  Prayer.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 02/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class Prayer {
    static let dataProvider = PrayersDataProvider.shared
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
            Prayer.dataProvider.saveContext()
            NotificationCenter.default.post(name: .prayerEditingChanged, object: self)
        }
    }
    
    init(managedPrayer: ManagedPrayerItem) {
        self.managedPrayer = managedPrayer
    }
    
    convenience init?(title: String) {
        let context = Prayer.dataProvider.context
        guard let managedPrayer = ManagedPrayerItem.fetchPrayer(withTitle: title, from: context) else {
            logError("Failed to fetch managed prayer item with title: \(title)")
            return nil
        }
        self.init(managedPrayer: managedPrayer)
    }
    
    static var favouritePrayers: [Prayer] {
        let context = Prayer.dataProvider.context
        guard let managedPrayers = ManagedPrayerItem.fetchFavouritePrayers(from: context) else {
            logError("Failed to fetch managed favourite prayers.")
            return []
        }
        return managedPrayers.map { Prayer(managedPrayer: $0) }
    }
}
