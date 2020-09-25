//
//  PrayerSectionHeader.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 26/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerSectionHeader: UITableViewHeaderFooterView {
    static let reuseID = "prayerHeader"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}
