//
//  PrayersDetailsViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 28/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayersDetailsViewController: UIViewController, PrayersDetailsTableDelegate {
    private var prayersDetailsTableViewController: PrayersDetailsTableViewController?
    
    var prayer: String?
    var section: String?
    var favouritesOnly: Bool = false
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
        configureTableViewController()
        reloadTableViewData()
    }
    
    // MARK: Private methods
    
    private func configureTableViewController() {
        let prayersDetailsTableViewController = PrayersDetailsTableViewController.fromNib()
        prayersDetailsTableViewController.delegate = self
        addChildController(prayersDetailsTableViewController)
        self.prayersDetailsTableViewController = prayersDetailsTableViewController
    }
    
    func reloadTableViewData() {
        let prayer = self.prayer ?? ""
        let section = self.section ?? ""
        let dataSource = PrayersDetailsTableDataSource(prayer: prayer, section: section, favouritesOnly: favouritesOnly)
        prayersDetailsTableViewController?.dataSource = dataSource
    }
    
    private func configureBackButton() {
        let backButton = UIBarButtonItem(title: "ÎNAPOI", style: .plain, target: nil, action: nil)
        backButton.tintColor = UIColor(named: "navigationBarTintColor")
        navigationItem.backBarButtonItem = backButton
    }
    
    // MARK: Prayers Details Table Delegate
    
    func didSelectPrayer(_ prayer: String) {
        log("did select prayer: \(prayer)")
        let prayerViewController = PrayerViewController.fromNib()
        prayerViewController.prayer = Prayer(title: prayer)
        prayerViewController.delegate = self
        navigationController?.pushViewController(prayerViewController, animated: true)
    }
}

extension PrayersDetailsViewController: PrayerViewControllerDelegate {
    func didChangePrayer(_ prayer: Prayer) {
        if favouritesOnly {
            let prayersViewController = navigationController?.viewControllers.first as? PrayersViewController
            prayersViewController?.needsTableViewUpdate = true
        }
    }
}
