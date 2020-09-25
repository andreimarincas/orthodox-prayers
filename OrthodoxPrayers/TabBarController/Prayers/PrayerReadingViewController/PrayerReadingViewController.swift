//
//  PrayerReadingViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 30/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerReadingViewController: UIViewController {
    private var prayer: Prayer!
    private var parentPrayer: String?
    private var section: String!
    
    private var tableViewController: PrayerReadingTableViewController!
    
    // MARK: Initialization
    
    convenience init(prayer: String, parentPrayer: String?, section: String) {
        self.init()
        self.prayer = Prayer(title: prayer)
        self.parentPrayer = parentPrayer
        self.section = section
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFavouriteButton()
        configureTableViewController()
    }
    
    // MARK: Private methods
    
    private func configureFavouriteButton() {
        let favouriteButton = ToggleButton()
        favouriteButton.image = UIImage(named: "heartIcon")
        favouriteButton.selectedImage = UIImage(named: "heartIconSelected")
        favouriteButton.isSelected = prayer.isFavourite
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped(_:)), for: .touchUpInside)
        let favouriteBarButton = UIBarButtonItem(customView: favouriteButton)
        navigationItem.rightBarButtonItem = favouriteBarButton
    }
    
    @objc private func favouriteButtonTapped(_ favouriteButton: ToggleButton) {
        log("is selected: \(favouriteButton.isSelected)")
        favouriteButton.toggle()
        prayer.isFavourite = favouriteButton.isSelected
    }
    
    private func configureTableViewController() {
        let tableViewController = PrayerReadingTableViewController(prayerTitle: prayer.title, parentPrayerTitle: parentPrayer, section: section)
        addChildController(tableViewController)
        self.tableViewController = tableViewController
    }
}

// MARK: UIGestureRecognizerDelegate

extension PrayerReadingViewController: UIGestureRecognizerDelegate {
    @IBAction func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        //guard let navigationController = self.navigationController else { return }
        var hidden = navigationController?.isNavigationBarHidden ?? false
        hidden.toggle()
        navigationController?.setNavigationBarHidden(hidden, animated: true)
        if !hidden {
            showStatusBar()
        }
        let tabBarController = self.tabBarController as? TabBarController
        tabBarController?.setTabBarHidden(hidden, animated: true)
    }
}
