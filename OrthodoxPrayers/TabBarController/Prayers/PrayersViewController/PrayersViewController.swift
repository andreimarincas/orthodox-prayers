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
    private var prayersTableViewController: PrayersTableViewController!
    private var needsReload = false
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: "PrayersViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        self.prayersTableViewController = tableViewController
    }
    
    private func reloadTableViewData(animated: Bool) {
        prayersTableViewController.reloadData(favouritesOnly: favouritesOnly, animated: animated)
        noFavouritesLabel.isHidden = !(favouritesOnly && prayersTableViewController.dataSource.isEmpty)
    }
    
    private func configureNoFavouritesLabel() {
        noFavouritesLabel.text = "Nu ai salvat nicio rugăciune la favorite" // TODO: Localize
        noFavouritesLabel.isHidden = !(favouritesOnly && prayersTableViewController.dataSource.isEmpty)
    }
    
    private func configureBackButton() {
//        let backButton = BarButtonItem(title: "ÎNAPOI", style: .plain, target: nil, action: nil)
//        let backButton = BarButtonItem(title: "ÎNAPOI", menuTitle: "Rugăciuni", menuHandler: { _ in
//            self.navigationController?.popToViewController(self, animated: true)
//        })
//        let backButton = BarButtonItem(title: "ÎNAPOI", menuTitle: "Rugăciuni", menuHandler: { _ in
//            self.navigationController?.popToViewController(self, animated: true)
//        })
        let backButton = BackBarButtonItem(title: "ÎNAPOI", menuTitle: "Rugăciuni")
        backButton.tintColor = .navigationBarTintColor
        navigationItem.backBarButtonItem = backButton
    }
    
    // MARK: Notification handling
    
    private func registerNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(favouritesSelectionChanged(_:)), name: Notifications.favouritesSelectionChanged, object: nil)
        notificationCenter.addObserver(self, selector: #selector(prayerEditingChanged(_:)), name: Notifications.prayerEditingChanged, object: nil)
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
    func didSelectPrayer(_ selectedPrayer: String, inSection section: String, isDetailedItem: Bool) {
        log("did select prayer: \(selectedPrayer)")
        if isDetailedItem {
            let detailsViewController = PrayersDetailsViewController(prayer: selectedPrayer, section: section)
            navigationController?.pushViewController(detailsViewController, animated: true)
        } else {
            let prayerViewController = PrayerViewController(prayer: selectedPrayer, parentPrayer: nil, section: section)
            navigationController?.pushViewController(prayerViewController, animated: true)
        }
    }
}
