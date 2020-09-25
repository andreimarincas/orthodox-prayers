//
//  PrayerViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 30/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerViewController: UIViewController {
    private let prayer: Prayer!
    private let parentPrayer: String?
    private let section: String
    
    private var prayerReadingViewController: PrayerReadingViewController!
    
    // MARK: Initialization
    
    init(prayer: String, parentPrayer: String?, section: String) {
        self.prayer = Prayer(title: prayer)
        self.parentPrayer = parentPrayer
        self.section = section
        super.init(nibName: "PrayerViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFavouriteButton()
        configurePrayerReadingViewController()
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
    
    private func configurePrayerReadingViewController() {
        let prayerReadingViewController = PrayerReadingViewController(prayerTitle: prayer.title, parentPrayerTitle: parentPrayer, section: section)
        addChildController(prayerReadingViewController)
        self.prayerReadingViewController = prayerReadingViewController
    }
}
