//
//  PrayerDetailsCell.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 26/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerDetailsCell: UITableViewCell {
    static let reuseID = "prayerDetailsCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var backgroundConfiguration = UIBackgroundConfiguration.listPlainCell().updated(for: state)
        if state.isHighlighted || state.isSelected {
            backgroundConfiguration.backgroundColor = .prayerCellSelectedColor
        } else {
            backgroundConfiguration.backgroundColor = .prayerCellBackgroundColor
        }
        self.backgroundConfiguration = backgroundConfiguration
    }
}
