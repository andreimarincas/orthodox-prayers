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
    
    private let prayer: String
    private let section: String
    private let favouritesOnly: Bool
    
    // MARK: Initialization
    
    init(prayer: String, section: String, favouritesOnly: Bool) {
        self.prayer = prayer
        self.section = section
        self.favouritesOnly = favouritesOnly
        super.init(nibName: "PrayersDetailsViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
        configureTableViewController()
    }
    
    // MARK: Private methods
    
    private func configureTableViewController() {
        let tableViewController = PrayersDetailsTableViewController(prayer: prayer, section: section, favouritesOnly: favouritesOnly)
        tableViewController.delegate = self
        addChildController(tableViewController)
        self.prayersDetailsTableViewController = tableViewController
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
        let prayerViewController = PrayerViewController(prayer: selectedPrayer, parentPrayerTitle: self.prayer, section: self.section)
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
