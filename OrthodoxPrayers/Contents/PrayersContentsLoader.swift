//
//  PrayersContentsLoader.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 26/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class PrayersContentsLoader {
    func loadPrayersPlistData() -> [String: Any]? {
        let url = Bundle.main.url(forResource: "PrayersContents", withExtension: "plist")!
        do {
            let data = try Data(contentsOf: url)
            let plistDictionary = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String: Any]
            return plistDictionary
        } catch {
            fatalError("Unresolved error: \(error)") // TODO: Handle error
        }
    }
}
