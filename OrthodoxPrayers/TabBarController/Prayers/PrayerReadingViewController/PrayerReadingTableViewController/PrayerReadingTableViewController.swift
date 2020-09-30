//
//  PrayerReadingTableViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 09/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerReadingTableViewController: TableViewController {
    private(set) var dataSource: PrayerReadingTableDataSource!
    var verticalContentOffset: (row: Int, percent: CGFloat)?
    
    // MARK: Initialization
    
    convenience init(prayerTitle: String, parentPrayerTitle: String?, section: String) {
        self.init()
        dataSource = PrayerReadingTableDataSource(prayer: prayerTitle, parent: parentPrayerTitle, section: section)
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.footerView = PrayerReadingFooter()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let offset = self.verticalContentOffset {
            tableView.layoutIfNeeded()
            tableView.scrollToRow(at: offset.row, percent: offset.percent)
            self.verticalContentOffset = nil
        }
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
