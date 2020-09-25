//
//  PrayerReadingTableViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 09/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerReadingTableViewController: UITableViewController {
    private let dataSource: PrayerReadingTableDataSource
    
    // MARK: Initialization
    
    init(prayerTitle: String, parentPrayerTitle: String?) {
        dataSource = PrayerReadingTableDataSource(prayer: prayerTitle, parent: parentPrayerTitle)
        super.init(nibName: "PrayerReadingTableViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: Private methods
    
    private func configureTableView() {
        let cellNib = UINib(nibName: "PrayerReadingCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: PrayerReadingCell.reuseID)
        tableView.tableFooterView = PrayerReadingFooter(frame: CGRect(x: 0, y: 0, width: 0, height: 52))
    }
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfItems
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let prayerReadingCell = tableView.dequeueReusableCell(withIdentifier: PrayerReadingCell.reuseID, for: indexPath) as? PrayerReadingCell else {
            fatalError("Failed to dequeue PrayerReadingCell.")
        }
        prayerReadingCell.attributedString = dataSource.prayerItem(at: indexPath.row)
        return prayerReadingCell
    }
}
