//
//  PrayerReadingViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 30/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerReadingViewController: UIViewController {
    private var prayerReadingTableViewController: PrayerReadingTableViewController!
    private let prayerTitle: String
    private let parentPrayerTitle: String?
    
    // MARK: Initialization
    
    init(prayerTitle: String, parentPrayerTitle: String?) {
        self.prayerTitle = prayerTitle
        self.parentPrayerTitle = parentPrayerTitle
        super.init(nibName: "PrayerReadingViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableViewController = PrayerReadingTableViewController(prayerTitle: prayerTitle, parentPrayerTitle: parentPrayerTitle)
        addChildController(tableViewController)
        self.prayerReadingTableViewController = tableViewController
    }
}
