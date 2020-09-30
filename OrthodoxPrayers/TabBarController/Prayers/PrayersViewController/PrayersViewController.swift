//
//  PrayersViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 23/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayersViewController: UIViewController {
    @IBOutlet weak var noFavouritesLabel: UILabel!
    private var tableViewController: PrayersTableViewController!
    private var needsReload = false
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewController()
        configureNoFavouritesLabel()
        configureBackButton()
        registerNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if needsReload {
            reloadTableViewData(animated: false)
            needsReload = false
        }
    }
    
    // MARK: Private methods
    
    private var favouritesOnly: Bool {
        let prayersNavigationController = navigationController as? PrayersNavigationController
        return prayersNavigationController?.favouritesOnly ?? false
    }
    
    private func configureTableViewController() {
        let tableViewController = PrayersTableViewController(favouritesOnly: favouritesOnly)
        tableViewController.delegate = self
        addChildController(tableViewController)
        self.tableViewController = tableViewController
    }
    
    private func reloadTableViewData(animated: Bool) {
        tableViewController.reloadData(favouritesOnly: favouritesOnly, animated: animated)
        noFavouritesLabel.isHidden = !(favouritesOnly && tableViewController.dataSource.isEmpty)
    }
    
    private func configureNoFavouritesLabel() {
        noFavouritesLabel.text = "Nu ai salvat nicio rugăciune la favorite" // TODO: Localize
        noFavouritesLabel.isHidden = !(favouritesOnly && tableViewController.dataSource.isEmpty)
    }
    
    private func configureBackButton() {
        let backButton = BackBarButtonItem(title: "Înapoi", menuTitle: "Rugăciuni")
        backButton.tintColor = .navigationBarTintColor
        navigationItem.backBarButtonItem = backButton
    }
    
    // MARK: Notification handling
    
    private func registerNotifications() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(favouritesSelectionChanged(_:)), name: .favouritesSelectionChanged)
        center.addObserver(self, selector: #selector(prayerEditingChanged(_:)), name: .prayerEditingChanged)
    }
    
    @objc private func favouritesSelectionChanged(_ notification: NSNotification) {
        if self == navigationController?.topViewController {
            reloadTableViewData(animated: true)
        } else {
            needsReload = true
        }
    }
    
    @objc private func prayerEditingChanged(_ notification: NSNotification) {
        if navigationController?.viewControllers.first(where: { $0 is PrayersDetailsViewController }) != nil {
            if favouritesOnly {
                needsReload = true
            }
        }
    }
}

// MARK: PrayersTableViewControllerDelegate

extension PrayersViewController: PrayersTableViewControllerDelegate {
    func didSelectPrayer(_ selectedPrayer: String, inSection section: String, hasPrayersDetails: Bool) {
        log("did select prayer: \(selectedPrayer)")
        if hasPrayersDetails {
            let detailsViewController = PrayersDetailsViewController(prayer: selectedPrayer, section: section)
            navigationController?.pushViewController(detailsViewController, animated: true)
        } else {
            let prayerViewController = PrayerReadingViewController(prayer: selectedPrayer, parentPrayer: nil, section: section)
            navigationController?.pushViewController(prayerViewController, animated: true)
        }
    }
}
