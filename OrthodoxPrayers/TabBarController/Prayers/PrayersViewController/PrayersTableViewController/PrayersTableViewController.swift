//
//  PrayersTableViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 24/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

protocol PrayersTableViewControllerDelegate: class {
    func didSelectPrayer(_ selectedPrayerTitle: String, inSection section: String, isDetailedItem: Bool)
}

class PrayersTableViewController: UITableViewController {
    private(set) var dataSource: PrayersDataSource
    weak var delegate: PrayersTableViewControllerDelegate?
    
    let sectionHeaderHeight: CGFloat = 60
    let emptyRowHeight: CGFloat = 36
    
    var favouritesOnly: Bool {
        return dataSource is FavouritePrayersDataSource
    }
    
    // MARK: Initialization
    
    init(favouritesOnly: Bool) {
        dataSource = favouritesOnly ? FavouritePrayersDataSource() : PrayersDataSource()
        super.init(nibName: "PrayersTableViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    // MARK: Public methods
    
    func reloadData(favouritesOnly: Bool, animated: Bool) {
        let oldDataSource = dataSource
        dataSource = favouritesOnly ? FavouritePrayersDataSource() : PrayersDataSource()
        if !animated {
            tableView?.reloadData()
            return
        }
        var sectionsToInsert = IndexSet()
        var sectionsToDelete = IndexSet()
        var sectionsToReload = IndexSet()
        let m = oldDataSource.numberOfSections
        let n = dataSource.numberOfSections
        if m < n {
            sectionsToInsert.insert(integersIn: m..<n)
        } else if m > n {
            sectionsToDelete.insert(integersIn: n..<m)
        }
        for index in 0..<min(m, n) {
            let oldTitle = oldDataSource.title(forSectionAt: index)
            let newTitle = dataSource.title(forSectionAt: index)
            if newTitle == oldTitle {
                sectionsToReload.insert(index)
            } else {
                sectionsToInsert.insert(index)
                sectionsToDelete.insert(index)
            }
        }
        tableView?.performBatchUpdates({
            tableView?.insertSections(sectionsToInsert, with: .fade)
            tableView?.deleteSections(sectionsToDelete, with: .fade)
            tableView?.reloadSections(sectionsToReload, with: .fade)
        })
        tableView?.hideVerticalScrollIndicator()
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
        let sectionTitle = dataSource.associatedSectionTitle(forSectionAt: indexPath.section)
        let isDetailed = dataSource.isDetailedItem(prayerItem: prayerItem, inSection: sectionTitle)
        delegate?.didSelectPrayer(prayerItem, inSection: sectionTitle, isDetailedItem: isDetailed)
    }
}
