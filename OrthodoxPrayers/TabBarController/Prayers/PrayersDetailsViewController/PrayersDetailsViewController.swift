//
//  PrayersDetailsViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 28/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayersDetailsViewController: UIViewController {
    private var prayersDetailsTableViewController: PrayersDetailsTableViewController!
    
    var prayer: String?
    var section: String?
    var favouritesOnly: Bool = false
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
        configureTableViewController()
        loadTableViewData()
    }
    
    // MARK: Private methods
    
    private func configureTableViewController() {
        let tableViewController = PrayersDetailsTableViewController.fromNib()
        tableViewController.delegate = self
        addChildController(tableViewController)
        self.prayersDetailsTableViewController = tableViewController
    }
    
    private func loadTableViewData() {
        let prayer = self.prayer ?? ""
        let section = self.section ?? ""
        let dataSource = PrayersDetailsTableDataSource(prayer: prayer, section: section, favouritesOnly: favouritesOnly)
        prayersDetailsTableViewController.dataSource = dataSource
    }
    
    private func configureBackButton() {
        let backButton = UIBarButtonItem(title: "ÎNAPOI", style: .plain, target: nil, action: nil)
        backButton.tintColor = .navigationBarTintColor
        navigationItem.backBarButtonItem = backButton
    }
}

// MARK: PrayersDetailsTableDelegate

extension PrayersDetailsViewController: PrayersDetailsTableDelegate {
    func didSelectPrayer(_ selectedPrayerTitle: String) {
        log("did select prayer: \(selectedPrayerTitle)")
        let selectedPrayer = Prayer(title: selectedPrayerTitle)!
        let prayerViewController = PrayerViewController(prayer: selectedPrayer, parentPrayerTitle: self.prayer!)
        prayerViewController.delegate = self
        navigationController?.pushViewController(prayerViewController, animated: true)
    }
}

// MARK: PrayerViewControllerDelegate

extension PrayersDetailsViewController: PrayerViewControllerDelegate {
    func didEditPrayer(_ prayer: Prayer) {
        if favouritesOnly {
            let prayersViewController = navigationController?.viewControllers.first as? PrayersViewController
            prayersViewController?.needsTableViewUpdate = true
        }
    }
}
