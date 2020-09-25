//
//  PrayersDetailsTableViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 28/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayersDetailsTableViewController: UITableViewController {
    var dataSource: PrayersDetailsTableDataSource?
    weak var delegate: PrayersDetailsTableDelegate?
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: Private methods
    
    private func configureTableView() {
        let cellNib = UINib(nibName: "PrayerDetailsCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: PrayerDetailsCell.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView() // hide empty rows
    }
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numberOfPrayers ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let prayerDetailsCell = tableView.dequeueReusableCell(withIdentifier: PrayerDetailsCell.reuseID, for: indexPath) as? PrayerDetailsCell else {
            fatalError("Failed to dequeue reusable PrayerDetailsCell.")
        }
        let prayer = dataSource?.prayerItem(at: indexPath.row) ?? ""
        prayerDetailsCell.textLabel?.text = prayer
        if !prayer.isEmpty {
            prayerDetailsCell.backgroundColor = UIColor(named: "prayerCellBgColor")
            prayerDetailsCell.selectionStyle = .default
            prayerDetailsCell.accessoryType = .disclosureIndicator
            prayerDetailsCell.isUserInteractionEnabled = true
        } else {
            prayerDetailsCell.backgroundColor = .clear
            prayerDetailsCell.selectionStyle = .none
            prayerDetailsCell.accessoryType = .none
            prayerDetailsCell.isUserInteractionEnabled = false
        }
        return prayerDetailsCell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataSource = dataSource else { return }
        let prayer = dataSource.prayerItem(at: indexPath.row)
        delegate?.didSelectPrayer(prayer)
    }
}
