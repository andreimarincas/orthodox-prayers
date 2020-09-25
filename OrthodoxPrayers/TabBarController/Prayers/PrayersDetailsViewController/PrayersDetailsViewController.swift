//
//  PrayersDetailsViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 28/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayersDetailsViewController: UIViewController {
    private var prayer: String!
    private var section: String!
    
    private var tableViewController: PrayersDetailsTableViewController!
    
    private var favouritesOnly: Bool {
        let prayersNavigationController = navigationController as? PrayersNavigationController
        return prayersNavigationController?.favouritesOnly ?? false
    }
    
    // MARK: Initialization
    
    convenience init(prayer: String, section: String) {
        self.init()
        self.prayer = prayer
        self.section = section
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewController()
        configureBackButton()
        registerNotifications()
    }
    
    // MARK: Configure methods
    
    private func configureTableViewController() {
        let tableViewController = PrayersDetailsTableViewController(prayer: prayer, section: section, favouritesOnly: favouritesOnly)
        tableViewController.delegate = self
        addChildController(tableViewController)
        self.tableViewController = tableViewController
    }
    
    private func configureBackButton() {
        let backButton = BackBarButtonItem(title: "ÎNAPOI", menuTitle: prayer)
        backButton.tintColor = .navigationBarTintColor
        navigationItem.backBarButtonItem = backButton
    }
    
    // MARK: Notification handling
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(favouritesSelectionChanged), name: Notifications.favouritesSelectionChanged, object: nil)
    }
    
    @objc private func favouritesSelectionChanged() {
        guard self == navigationController?.topViewController else {
            logWarn("How did you get here?")
            return
        }
        tableViewController.reloadData(prayer: prayer, section: section, favouritesOnly: favouritesOnly, animated: true)
    }
}

// MARK: PrayersDetailsTableViewControllerDelegate

extension PrayersDetailsViewController: PrayersDetailsTableViewControllerDelegate {
    func didSelectPrayer(_ selectedPrayer: String) {
        log("did select prayer: \(selectedPrayer)")
        let prayerViewController = PrayerReadingViewController(prayer: selectedPrayer, parentPrayer: self.prayer, section: self.section)
        navigationController?.pushViewController(prayerViewController, animated: true)
    }
}
