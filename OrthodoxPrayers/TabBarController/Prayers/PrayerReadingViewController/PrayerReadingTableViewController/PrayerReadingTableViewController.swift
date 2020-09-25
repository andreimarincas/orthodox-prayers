//
//  PrayerReadingTableViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 09/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerReadingTableViewController: TableViewController {
    private var prayerTitle: String!
    private var parentPrayerTitle: String?
    private var section: String!
    
    private var dataSource: PrayerReadingTableDataSource!
    
    // MARK: Initialization
    
    convenience init(prayerTitle: String, parentPrayerTitle: String?, section: String) {
        self.init()
        self.prayerTitle = prayerTitle
        self.parentPrayerTitle = parentPrayerTitle
        self.section = section
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = PrayerReadingTableDataSource(prayer: prayerTitle, parent: parentPrayerTitle, section: section)
        tableView.footerView = PrayerReadingFooter()
    }
    
    // MARK: TableViewDataSource
    
    override func numberOfRows(in tableView: TableView) -> Int {
        return dataSource.numberOfItems
    }
    
    override func tableView(_ tableView: TableView, cellForRowAt index: Int) -> UIView {
        let cell = PrayerReadingCell()
        cell.attributedString = dataSource.prayerItem(at: index)
        return cell
    }
}
