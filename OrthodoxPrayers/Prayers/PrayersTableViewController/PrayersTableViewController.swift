//
//  PrayersTableViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 24/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayersTableViewController: UITableViewController {
    
    var dataSource: PrayersTableDataSource? {
        didSet {
            tableView?.reloadData()
        }
    }
    
    weak var delegate: PrayersTableDelegate?
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: Private methods
    
    private func configureTableView() {
        let cellNib = UINib(nibName: "PrayerCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: PrayerCell.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
        let headerNib = UINib(nibName: "PrayerSectionHeader", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: PrayerSectionHeader.reuseID)
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.numberOfSections ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numberOfPrayers(inSectionAt: section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let prayerCell = tableView.dequeueReusableCell(withIdentifier: PrayerCell.reuseID, for: indexPath) as? PrayerCell else {
            fatalError("Failed to dequeue reusable PrayerCell.")
        }
        let prayerItem = dataSource?.prayerItem(at: indexPath.row, inSectionAt: indexPath.section) ?? ""
        prayerCell.textLabel?.text = prayerItem
        if !prayerItem.isEmpty {
            prayerCell.backgroundColor = UIColor(named: "prayerCellBgColor")
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
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: PrayerSectionHeader.reuseID) as? PrayerSectionHeader ?? PrayerSectionHeader(reuseIdentifier: PrayerSectionHeader.reuseID)
        sectionHeader.titleLabel.text = dataSource?.sectionTitle(forSectionAt: section)
        return sectionHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataSource = dataSource else { return }
        let prayerItem = dataSource.prayerItem(at: indexPath.row, inSectionAt: indexPath.section)
        let sectionTitle = dataSource.sectionTitle(forSectionAt: indexPath.section)
        delegate?.didSelectPrayer(prayerItem, inSection: sectionTitle)
    }
}
