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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSelectionColor()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
    }
    
    private func configureSelectionColor() {
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .prayerCellHighlightColor
        self.selectedBackgroundView = selectedBackgroundView
    }
}
