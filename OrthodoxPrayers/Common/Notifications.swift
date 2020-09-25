//
//  Notifications.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 17/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

struct Notifications {
    static let favouritesSelectionChanged = NSNotification.Name("OrthodoxPrayers.FavouritesSelectionChanged")
    static let prayerEditingChanged = NSNotification.Name("OrthodoxPrayers.PrayerEditingChanged")
    static let needsStatusBarAppearanceUpdate = NSNotification.Name("OrthodoxPrayers.needsStatusBarAppearanceUpdate")
}
