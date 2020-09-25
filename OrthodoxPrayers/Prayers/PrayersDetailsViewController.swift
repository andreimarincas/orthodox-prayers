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
    
    var data: (prayer: String, section: String)? {
        didSet {
            reloadTableViewData()
        }
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableViewController()
        reloadTableViewData()
    }
    
    // MARK: Private methods
    
    private func configureNavigationBar() {
        navigationItem.titleView = FavouritesControl.fromNib()
        let backButton = UIBarButtonItem(title: "ÎNAPOI", style: .plain, target: nil, action: nil)
        backButton.tintColor = UIColor(named: "navigationBarTintColor")
        navigationItem.backBarButtonItem = backButton
    }
    
    private func configureTableViewController() {
        let prayersDetailsTableViewController = PrayersDetailsTableViewController.fromNib()
        prayersDetailsTableViewController.delegate = self
        addChildController(prayersDetailsTableViewController)
        self.prayersDetailsTableViewController = prayersDetailsTableViewController
    }
    
    private func reloadTableViewData() {
        guard let _ = self.prayersDetailsTableViewController else { return }
        let prayer = self.data?.prayer ?? ""
        let section = self.data?.section ?? ""
        let dataSource = PrayersDetailsTableDataSource(prayer: prayer, section: section)
        self.prayersDetailsTableViewController?.dataSource = dataSource
    }
    
    // MARK: Prayers Details Table Delegate
    
    func didSelectPrayer(_ prayer: String) {
        log("did select prayer: \(prayer)")
        let prayerViewController = PrayerViewController.fromNib()
        prayerViewController.prayer = prayer
        navigationController?.pushViewController(prayerViewController, animated: true)
    }
}
