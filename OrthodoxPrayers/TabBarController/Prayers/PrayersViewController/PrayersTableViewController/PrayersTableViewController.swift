//
//  PrayersTableViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 24/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayersTableViewController: UITableViewController {
    var dataSource: PrayersTableDataSourceProtocol = PrayersTableDataSource()
    weak var delegate: PrayersTableDelegate?
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "PrayerCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: PrayerCell.reuseID)
        let headerNib = UINib(nibName: "PrayerSectionHeader", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: PrayerSectionHeader.reuseID)
    }
    
    // MARK: Public methods
    
    func updateTableView(data newDataSource: PrayersTableDataSource, animated: Bool) {
        let oldDataSource = self.dataSource
        self.dataSource = newDataSource
        if !animated {
            tableView?.reloadData()
            return
        }
        var sectionsToInsert = IndexSet()
        var sectionsToDelete = IndexSet()
        var sectionsToReload = IndexSet()
        let m = oldDataSource.numberOfSections
        let n = newDataSource.numberOfSections
        if m < n {
            sectionsToInsert.insert(integersIn: m..<n)
        } else if m > n {
            sectionsToDelete.insert(integersIn: n..<m)
        }
        for i in 0..<min(m, n) {
            let oldTitle = oldDataSource.title(forSectionAt: i)
            let newTitle = newDataSource.title(forSectionAt: i)
            if newTitle == oldTitle {
                sectionsToReload.insert(i)
            } else {
                sectionsToInsert.insert(i)
                sectionsToDelete.insert(i)
            }
        }
        tableView?.performBatchUpdates({
            tableView?.insertSections(sectionsToInsert, with: .fade)
            tableView?.deleteSections(sectionsToDelete, with: .fade)
            tableView?.reloadSections(sectionsToReload, with: .fade)
        })
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfPrayers(inSectionAt: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let prayerCell = tableView.dequeueReusableCell(withIdentifier: PrayerCell.reuseID, for: indexPath) as? PrayerCell else {
            fatalError("Failed to dequeue reusable PrayerCell.")
        }
        let prayerItem = dataSource.prayerItem(at: indexPath.row, inSectionAt: indexPath.section)
        prayerCell.textLabel?.text = prayerItem
        if !prayerItem.isEmpty {
            prayerCell.backgroundColor = .prayerCellBackgroundColor
            prayerCell.selectionStyle = .default
            prayerCell.accessoryType = .disclosureIndicator
            prayerCell.isUserInteractionEnabled = true
        } else {
            prayerCell.backgroundColor = .clear
            prayerCell.selectionStyle = .none
            prayerCell.accessoryType = .none
            prayerCell.isUserInteractionEnabled = false
        }
        return prayerCell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: PrayerSectionHeader.reuseID) as? PrayerSectionHeader ?? PrayerSectionHeader()
        sectionHeader.titleLabel.text = dataSource.title(forSectionAt: section)
        return sectionHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prayerItem = dataSource.prayerItem(at: indexPath.row, inSectionAt: indexPath.section)
        let sectionTitle = dataSource.title(forSectionAt: indexPath.section)
        delegate?.didSelectPrayer(prayerItem, inSection: sectionTitle)
    }
}
