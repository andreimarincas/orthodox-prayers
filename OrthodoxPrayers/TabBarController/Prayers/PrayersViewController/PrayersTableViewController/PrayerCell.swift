//
//  PrayerCell.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 26/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerCell: UITableViewCell {
    static let reuseID = "prayerCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = selected ? .prayerCellSelectedColor : .prayerCellBackgroundColor
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        backgroundColor = highlighted ? .prayerCellSelectedColor : .prayerCellBackgroundColor
    }
}
