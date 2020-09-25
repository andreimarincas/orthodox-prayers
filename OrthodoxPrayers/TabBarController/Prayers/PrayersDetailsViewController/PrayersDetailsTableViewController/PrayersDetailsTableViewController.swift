//
//  PrayersDetailsTableViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 28/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

protocol PrayersDetailsTableViewControllerDelegate: class {
    func didSelectPrayer(_ selectedPrayer: String)
}

class PrayersDetailsTableViewController: UITableViewController {
    private(set) var dataSource: PrayersDetailsDataSourceProtocol!
    weak var delegate: PrayersDetailsTableViewControllerDelegate?
    
    let sectionHeaderHeight: CGFloat = 60
    let emptyRowHeight: CGFloat = 36
    
    var favouritesOnly: Bool {
        return dataSource is FavouritePrayersDetailsDataSource
    }
    
    // MARK: Initialization
    
    convenience init(prayer: String, section: String, favouritesOnly: Bool) {
        self.init()
        dataSource = favouritesOnly ? FavouritePrayersDetailsDataSource(prayer: prayer, section: section) : AllPrayersDetailsDataSource(prayer: prayer, section: section)
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.scrollsToTop = false
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Call layoutIfNeeded on table view here to fix a bug where the cell separator is not visible in some cases on interactive pop gesture.
        tableView.layoutIfNeeded()
    }
    
    // MARK: Public methods
    
    func reloadData(prayer: String, section: String, favouritesOnly: Bool, animated: Bool) {
        let newDataSource: PrayersDetailsDataSourceProtocol = favouritesOnly ? FavouritePrayersDetailsDataSource(prayer: prayer, section: section) : AllPrayersDetailsDataSource(prayer: prayer, section: section)
        if animated {
            let prevSectionsCount = dataSource.numberOfSections
            dataSource = newDataSource
            let sectionsCount = dataSource.numberOfSections
            tableView?.reloadDataAnimated(numberOfSections: sectionsCount, previousNumberOfSections: prevSectionsCount)
        } else {
            dataSource = newDataSource
            tableView?.reloadData()
        }
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfPrayers(inSectionAt: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let prayerDetailsCell = tableView.dequeueReusableCell(withIdentifier: PrayerDetailsCell.reuseID, for: indexPath) as? PrayerDetailsCell else {
            fatalError("Failed to dequeue reusable PrayerDetailsCell.")
        }
        let prayer = dataSource.prayerItem(at: indexPath.row, inSectionAt: indexPath.section)
        prayerDetailsCell.textLabel?.text = prayer
        return prayerDetailsCell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: PrayerDetailsSectionHeader.reuseID) as? PrayerDetailsSectionHeader ?? PrayerDetailsSectionHeader()
        sectionHeader.titleLabel.text = dataSource.title
        return sectionHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 0) ? sectionHeaderHeight : emptyRowHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude // hide section footer
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prayer = dataSource.prayerItem(at: indexPath.row, inSectionAt: indexPath.section)
        delegate?.didSelectPrayer(prayer)
    }
}
