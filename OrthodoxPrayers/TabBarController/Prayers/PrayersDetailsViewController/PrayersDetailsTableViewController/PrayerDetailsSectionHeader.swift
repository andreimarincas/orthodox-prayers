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
    let titlePadding = UIEdgeInsets(top: 22, left: 16, bottom: 22, right: 16)
    
    convenience init() {
        self.init(reuseIdentifier: PrayerDetailsSectionHeader.reuseID)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let titleSizeToFit = size.subtractingInset(titlePadding)
        let titleSizeThatFits = titleLabel.sizeThatFits(titleSizeToFit)
        return titleSizeThatFits.addingInset(titlePadding)
    }
}
