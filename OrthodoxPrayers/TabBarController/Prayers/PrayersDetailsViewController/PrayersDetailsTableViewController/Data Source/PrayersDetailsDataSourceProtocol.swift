//
//  PrayersDetailsDataSourceProtocol.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 20/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

protocol PrayersDetailsDataSourceProtocol {
    
    var title: String { get }
    
    var numberOfSections: Int { get }
    
    var isEmpty: Bool { get }
    
    func numberOfPrayers(inSectionAt sectionIndex: Int) -> Int
    
    func prayerItem(at index: Int, inSectionAt sectionIndex: Int) -> String
}
