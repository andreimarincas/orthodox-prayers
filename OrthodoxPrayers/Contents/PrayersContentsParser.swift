//
//  PrayersContentsParser.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 26/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

class PrayersContentsParser {
    static let shared: PrayersContentsParser = {
        let loader = PrayersContentsLoader()
        if let plistData = loader.loadPrayersData() {
            return PrayersContentsParser(plistData: plistData)
        } else {
            logError("Failed to load plist data.")
            return PrayersContentsParser(plistData: [:])
        }
    }()
    
    private let plistData: [String: Any]
    
    private init(plistData: [String: Any]) {
        self.plistData = plistData
    }
    
    func parseAllPrayers() -> [String] {
        var result = [String]()
        let contents = plistData["Contents"] as! [[String: Any]]
        for section in contents {
            let items = section["Items"] as! [Any]
            for prayerItem in items {
                if let itemValue = prayerItem as? String {
                    result.append(itemValue)
                    continue
                }
                let detailedSection = prayerItem as! [String: Any]
                let detailedItems = detailedSection["Items"] as! [String]
                result += detailedItems
            }
        }
        return result
    }
    
    func parsePrayerSections() -> [String] {
        var result = [String]()
        let contents = plistData["Contents"] as! [[String: Any]]
        for section in contents {
            result.append(section["Title"] as! String)
        }
        return result
    }
    
    func parsePrayerItemsPerSection() -> [String: [String]] {
        var result = [String: [String]]()
        let contents = plistData["Contents"] as! [[String: Any]]
        for section in contents {
            let sectionTitle = section["Title"] as! String
            let items = section["Items"] as! [Any]
            var sectionItems = [String]()
            for item in items {
                if let itemValue = item as? String {
                    sectionItems.append(itemValue)
                    continue
                }
                let detailedSection = item as! [String: Any]
                let detailedSectionTitle = detailedSection["Title"] as! String
                sectionItems.append(detailedSectionTitle)
            }
            result[sectionTitle] = sectionItems
        }
        return result
    }
    
    func parsePrayerDetailedItems(forPrayer prayerItem: String, inSection sectionTitle: String) -> [String] {
        let contents = plistData["Contents"] as! [[String: Any]]
        guard let section = contents.first(where: { $0["Title"] as! String == sectionTitle }) else {
            logError("Couldn't find section: \(sectionTitle)")
            return []
        }
        let items = section["Items"] as! [Any]
        guard let detailedSection = items.first(where: { item -> Bool in
            guard let detailedItem = item as? [String: Any] else {
                return false
            }
            return detailedItem["Title"] as! String == prayerItem
        }) as? [String: Any] else {
            logError("Couldn't find prayer item: \(prayerItem) in section: \(sectionTitle)")
            return []
        }
        let detailedItems = detailedSection["Items"] as! [String]
        return detailedItems
    }
    
    func isDetailedItem(prayerItem: String, inSection sectionTitle: String) -> Bool? {
        let contents = plistData["Contents"] as! [[String: Any]]
        guard let section = contents.first(where: { $0["Title"] as! String == sectionTitle }) else {
            logError("Couldn't find section: \(sectionTitle)")
            return nil
        }
        let items = section["Items"] as! [Any]
        for item in items {
            if let itemValue = item as? String, itemValue == prayerItem {
                return false
            }
            if let detailedSection = item as? [String: Any] {
                let detailedSectionTitle = detailedSection["Title"] as! String
                if detailedSectionTitle == prayerItem {
                    return true
                }
            }
        }
        logError("Couldn't find prayer item: \(prayerItem) in section: \(sectionTitle)")
        return nil
    }
}
