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
    
    private var isFullscreen = false
    
    // MARK: Initialization
    
    convenience init(prayer: String, parentPrayer: String?, section: String) {
        self.init()
        self.prayer = Prayer(title: prayer)!
        self.parentPrayer = parentPrayer
        self.section = section
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFavouriteButton()
        configureTableViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // If text size has changed, cross-fade to a new PrayerReadingTableViewController
        let currentTextSize = tableViewController.dataSource.textSize
        let userTextSize = CGFloat(UserDefaults.standard.textSize)
        if currentTextSize != userTextSize {
            let newTableViewController = PrayerReadingTableViewController(prayerTitle: prayer.title, parentPrayerTitle: parentPrayer, section: section)
            newTableViewController.verticalContentOffset = tableViewController.tableView.verticalContentOffset
            transition(from: tableViewController, to: newTableViewController, duration: 0.4, options: .transitionCrossDissolve) { finished in
                self.tableViewController = newTableViewController
            }
        }
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
        // Toggle fullscreen mode
        isFullscreen.toggle()
        // Hide/show navigation bar
        navigationController?.setNavigationBarHidden(isFullscreen, animated: true)
        // Hide/show tab bar
        let tabBarController = self.tabBarController as? TabBarController
        tabBarController?.setTabBarHidden(isFullscreen, animated: true)
        // Notify enter/exit fullscreen
        NotificationCenter.default.post(name: isFullscreen ? .enterFullscreen : .exitFullscreen)
    }
}
