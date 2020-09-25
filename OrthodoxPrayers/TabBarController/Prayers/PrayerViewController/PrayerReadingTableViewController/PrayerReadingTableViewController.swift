//
//  PrayerReadingTableViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 09/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerReadingTableViewController: TableViewController {
    private let prayerTitle: String
    private let parentPrayerTitle: String?
    private let section: String
    
    private var dataSource: PrayerReadingTableDataSource!
    
    // MARK: Initialization
    
    init(prayerTitle: String, parentPrayerTitle: String?, section: String) {
        self.prayerTitle = prayerTitle
        self.parentPrayerTitle = parentPrayerTitle
        self.section = section
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = PrayerReadingTableDataSource(prayer: prayerTitle, parent: parentPrayerTitle, section: section)
        tableView.reloadData()
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
