//
//  PrayersDataSourceProtocol.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 19/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

protocol PrayersDataSourceProtocol {
    
    var numberOfSections: Int { get }
    
    func title(forSectionAt sectionIndex: Int) -> String?
    
    func associatedTitle(forSectionAt sectionIndex: Int) -> String
    
    func numberOfPrayers(inSectionAt sectionIndex: Int) -> Int
    
    func prayerItem(at index: Int, inSectionAt sectionIndex: Int) -> String
    
    func hasPrayersDetails(forPrayerItemAt prayerIndex: Int, inSectionAt sectionIndex: Int) -> Bool
}

extension PrayersDataSourceProtocol {
    
    var isEmpty: Bool {
        return numberOfSections == 0
    }
    
    func indexPathForPrayer(prayer: String) -> IndexPath? {
        for sectionIndex in 0..<numberOfSections {
            for prayerIndex in 0..<numberOfPrayers(inSectionAt: sectionIndex) {
                let prayerItem = self.prayerItem(at: prayerIndex, inSectionAt: sectionIndex)
                if prayerItem == prayer {
                    return IndexPath(row: prayerIndex, section: sectionIndex)
                }
            }
        }
        return nil
    }
}
