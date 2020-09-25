//
//  FavouritesControl.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 27/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class FavouritesControl: UISegmentedControl {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitle("Toate", forSegmentAt: 0)      // TODO: Localize
        setTitle("Favorite", forSegmentAt: 1)   // TODO: Localize
    }
}
