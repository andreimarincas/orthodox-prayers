//
//  PrayersViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 23/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayersViewController: UIViewController, PrayersTableDelegate {
    private var prayersTableViewController: PrayersTableViewController?
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePrayersTableViewController()
        configureNavigationBar()
    }
    
    // MARK: Private methods
    
    private func configurePrayersTableViewController() {
        let prayersTableViewController = PrayersTableViewController.fromNib()
        prayersTableViewController.dataSource = PrayersTableDataSource()
        prayersTableViewController.delegate = self
        addChildController(prayersTableViewController)
        self.prayersTableViewController = prayersTableViewController
    }
    
    private func configureNavigationBar() {
        navigationItem.titleView = FavouritesControl.fromNib()
        let backButton = UIBarButtonItem(title: "ÎNAPOI", style: .plain, target: nil, action: nil)
        backButton.tintColor = UIColor(named: "navigationBarTintColor")
        navigationItem.backBarButtonItem = backButton
    }
    
    // MARK: Prayers Table Delegate
    
    func didSelectPrayer(_ prayer: String, inSection section: String) {
        log("did select prayer: \(prayer)")
        let parser = PrayersContentsParser.shared
        guard let isDetailedItem = parser.isDetailedItem(prayerItem: prayer, inSection: section) else {
            logError("Couldn't find prayer: \(prayer) in section: \(section)")
            return
        }
        if isDetailedItem {
            let prayersDetailsViewController = PrayersDetailsViewController.fromNib()
            prayersDetailsViewController.data = (prayer: prayer, section: section)
            navigationController?.pushViewController(prayersDetailsViewController, animated: true)
        } else {
            let prayerViewController = PrayerViewController.fromNib()
            prayerViewController.prayer = prayer
            navigationController?.pushViewController(prayerViewController, animated: true)
        }
    }
}
