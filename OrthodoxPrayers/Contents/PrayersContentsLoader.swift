//
//  PrayersContentsLoader.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 26/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class PrayersContentsLoader {
    static let plist = "PrayersContents"
    
    func loadPrayersData(fromPlist plist: String = PrayersContentsLoader.plist) -> [String: Any]? {
        let url = Bundle.main.url(forResource: plist, withExtension: "plist")!
        do {
            let data = try Data(contentsOf: url)
            let root = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String: Any]
            return root
        } catch {
            fatalError("Unresolved error: \(error)") // TODO: Handle error
        }
    }
}
