//
//  PrayersTableDelegate.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 28/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

protocol PrayersTableDelegate: class {
    
    func didSelectPrayer(_ prayer: String, inSection section: String)
}
