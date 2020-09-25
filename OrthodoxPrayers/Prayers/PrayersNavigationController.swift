//
//  PrayersNavigationController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 27/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayersNavigationController: UINavigationController {
    
    // MARK: Initialization
    
    init() {
        let prayersViewController = PrayersViewController.fromNib()
        super.init(rootViewController: prayersViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
