//
//  PrayersTableViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 24/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

protocol PrayersTableViewControllerDelegate: class {
    func didSelectPrayer(_ selectedPrayer: String, inSection section: String, hasPrayersDetails: Bool)
}

class PrayersTableViewController: UITableViewController {
    private(set) var dataSource: PrayersDataSourceProtocol!
    weak var delegate: PrayersTableViewControllerDelegate?
    
    let sectionHeaderHeight: CGFloat = 60
    let emptyRowHeight: CGFloat = 36
    
    var favouritesOnly: Bool {
        return dataSource is FavouritePrayersDataSource
    }
    
    private var selectedPrayer: String?
    
    // MARK: Initialization
    
    convenience init(favouritesOnly: Bool) {
        self.init()
        dataSource = favouritesOnly ? FavouritePrayersDataSource() : AllPrayersDataSource()
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.scrollsToTop = false
        // Register cell
        let cellNib = UINib(nibName: "PrayerCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: PrayerCell.reuseID)
        // Register section header
        let headerNib = UINib(nibName: "PrayerSectionHeader", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: PrayerSectionHeader.reuseID)
        // Table view footer
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: emptyRowHeight))
        footer.backgroundColor = .clear
        tableView.tableFooterView = footer
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Re-select the prayer cell because selection was lost on reload data
        if let selectedPrayer = self.selectedPrayer {
            if tableView.indexPathForSelectedRow == nil {
                let indexPath = dataSource.indexPathForPrayer(prayer: selectedPrayer)
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
            self.selectedPrayer = nil
        }
        super.viewWillAppear(animated) // clears selection
        // Call layoutIfNeeded on table view here to fix a bug where the cell separator is not visible in some cases on interactive pop gesture.
        // layoutIfNeeded is also necessary for the row selection above.
        tableView.layoutIfNeeded()
    }
    
    // MARK: Public methods
    
    func reloadData(favouritesOnly: Bool, animated: Bool) {
        let newDataSource: PrayersDataSourceProtocol = favouritesOnly ? FavouritePrayersDataSource() : AllPrayersDataSource()
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
        guard let prayerCell = tableView.dequeueReusableCell(withIdentifier: PrayerCell.reuseID, for: indexPath) as? PrayerCell else {
            fatalError("Failed to dequeue reusable PrayerCell.")
        }
        let prayerItem = dataSource.prayerItem(at: indexPath.row, inSectionAt: indexPath.section)
        prayerCell.textLabel?.text = prayerItem
        return prayerCell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionTitle = dataSource.title(forSectionAt: section) else { return nil }
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: PrayerSectionHeader.reuseID) as? PrayerSectionHeader ?? PrayerSectionHeader()
        sectionHeader.titleLabel.text = sectionTitle
        return sectionHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionTitle = dataSource.title(forSectionAt: section)
        return (sectionTitle != nil) ? sectionHeaderHeight : emptyRowHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude // hide section footer
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prayerItem = dataSource.prayerItem(at: indexPath.row, inSectionAt: indexPath.section)
        let sectionTitle = dataSource.associatedTitle(forSectionAt: indexPath.section)
        let hasDetails = dataSource.hasPrayersDetails(forPrayerItemAt: indexPath.row, inSectionAt: indexPath.section)
        selectedPrayer = prayerItem
        delegate?.didSelectPrayer(prayerItem, inSection: sectionTitle, hasPrayersDetails: hasDetails)
    }
}
