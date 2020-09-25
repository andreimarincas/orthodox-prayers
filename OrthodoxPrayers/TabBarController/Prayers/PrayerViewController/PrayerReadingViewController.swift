//
//  PrayerReadingViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 30/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerReadingViewController: UIViewController {
    private let prayerTitle: String
    private let parentPrayerTitle: String?
    private let section: String
    
    private var prayerReadingTableViewController: PrayerReadingTableViewController!
    
    // MARK: Initialization
    
    init(prayerTitle: String, parentPrayerTitle: String?, section: String) {
        self.prayerTitle = prayerTitle
        self.parentPrayerTitle = parentPrayerTitle
        self.section = section
        super.init(nibName: "PrayerReadingViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableViewController = PrayerReadingTableViewController(prayerTitle: prayerTitle, parentPrayerTitle: parentPrayerTitle, section: section)
        addChildController(tableViewController)
        self.prayerReadingTableViewController = tableViewController
    }
}
