//
//  PrayersDetailsTableViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 28/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayersDetailsTableViewController: UITableViewController {
    private let prayer: String
    private let dataSource: PrayersDetailsTableDataSource
    weak var delegate: PrayersDetailsTableDelegate?
    
    let minimumSectionHeaderHeight: CGFloat = 62
    let emptyRowHeight: CGFloat = 36
    
    // MARK: Initialization
    
    init(prayer: String, section: String, favouritesOnly: Bool) {
        self.prayer = prayer
        self.dataSource = PrayersDetailsTableDataSource(prayer: prayer, section: section, favouritesOnly: favouritesOnly)
        super.init(nibName: "PrayersDetailsTableViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell
        let cellNib = UINib(nibName: "PrayerDetailsCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: PrayerDetailsCell.reuseID)
        // Register section header
        let headerNib = UINib(nibName: "PrayerDetailsSectionHeader", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: PrayerDetailsSectionHeader.reuseID)
        // Table view footer
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: emptyRowHeight))
        footer.backgroundColor = .clear
        tableView.tableFooterView = footer
    }
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfPrayers
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let prayerDetailsCell = tableView.dequeueReusableCell(withIdentifier: PrayerDetailsCell.reuseID, for: indexPath) as? PrayerDetailsCell else {
            fatalError("Failed to dequeue reusable PrayerDetailsCell.")
        }
        let prayer = dataSource.prayerItem(at: indexPath.row)
        prayerDetailsCell.textLabel?.text = prayer
        return prayerDetailsCell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: PrayerDetailsSectionHeader.reuseID) as? PrayerDetailsSectionHeader ?? PrayerDetailsSectionHeader()
        sectionHeader.titleLabel.text = prayer
        return sectionHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let header = self.tableView(tableView, viewForHeaderInSection: section) as! PrayerDetailsSectionHeader
        let size = header.sizeThatFits(CGSize(width: tableView.frame.width, height: .greatestFiniteMagnitude))
        return max(size.height, minimumSectionHeaderHeight)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude // hide section footer
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prayer = dataSource.prayerItem(at: indexPath.row)
        delegate?.didSelectPrayer(prayer)
    }
}
