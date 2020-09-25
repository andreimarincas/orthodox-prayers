//
//  PrayersDetailsViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 28/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayersDetailsViewController: UIViewController {
    private let prayer: String
    private let section: String
    
    private var prayersDetailsTableViewController: PrayersDetailsTableViewController!
    
    // MARK: Initialization
    
    init(prayer: String, section: String) {
        self.prayer = prayer
        self.section = section
        super.init(nibName: "PrayersDetailsViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewController()
        configureBackButton()
        registerNotifications()
    }
    
    // MARK: Private methods
    
    private var favouritesOnly: Bool {
        let prayersNavigationController = navigationController as? PrayersNavigationController
        return prayersNavigationController?.favouritesOnly ?? false
    }
    
    private func configureTableViewController() {
        let tableViewController = PrayersDetailsTableViewController(prayer: prayer, section: section, favouritesOnly: favouritesOnly)
        tableViewController.delegate = self
        addChildController(tableViewController)
        self.prayersDetailsTableViewController = tableViewController
    }
    
    private func configureBackButton() {
//        let backButton = BarButtonItem(title: "ÎNAPOI", style: .plain, target: nil, action: nil)
//        let backButton = BarButtonItem(title: "ÎNAPOI", menuTitle: prayer, menuHandler: { _ in
//            self.navigationController?.popToViewController(self, animated: true)
//        })
        let backButton = BackBarButtonItem(title: "ÎNAPOI", menuTitle: prayer)
        backButton.tintColor = .navigationBarTintColor
        navigationItem.backBarButtonItem = backButton
    }
    
//    private func configureBackButton() {
//        let backButton = UIBarButtonItem(title: "ÎNAPOI", style: .done, target: self, action: #selector(popViewController(_:)))
//        navigationItem.leftBarButtonItem = backButton
//    }
//
//    @objc func popViewController(_ sender: UIBarButtonItem) {
//       navigationController?.popViewController(animated: true)
//    }
    
    // MARK: Notification handling
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(favouritesSelectionChanged), name: Notifications.favouritesSelectionChanged, object: nil)
    }
    
    @objc private func favouritesSelectionChanged() {
        guard self == navigationController?.topViewController else {
            logWarn("How did you get here?")
            return
        }
        prayersDetailsTableViewController.reloadData(prayer: prayer, section: section, favouritesOnly: favouritesOnly, animated: true)
    }
}

// MARK: PrayersDetailsTableViewControllerDelegate

extension PrayersDetailsViewController: PrayersDetailsTableViewControllerDelegate {
    func didSelectPrayer(_ selectedPrayer: String) {
        log("did select prayer: \(selectedPrayer)")
        let prayerViewController = PrayerViewController(prayer: selectedPrayer, parentPrayer: self.prayer, section: self.section)
        navigationController?.pushViewController(prayerViewController, animated: true)
    }
}
