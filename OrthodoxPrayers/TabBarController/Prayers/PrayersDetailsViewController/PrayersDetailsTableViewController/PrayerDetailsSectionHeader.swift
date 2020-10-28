//
//  PrayerDetailsSectionHeader.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 15/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerDetailsSectionHeader: UITableViewHeaderFooterView {
    static let reuseID = "prayerDetailsSectionHeader"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    convenience init() {
        self.init(reuseIdentifier: PrayerDetailsSectionHeader.reuseID)
    }
}
