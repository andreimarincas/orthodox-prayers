//
//  PrayerSectionHeader.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 26/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerSectionHeader: UITableViewHeaderFooterView {
    static let reuseID = "prayerSectionHeader"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    convenience init() {
        self.init(reuseIdentifier: PrayerSectionHeader.reuseID)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}
