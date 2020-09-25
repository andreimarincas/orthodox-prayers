//
//  PrayerViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 30/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerViewController: UIViewController {
    var prayer: String?
    private var prayerReadingViewController: PrayerReadingViewController?
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configurePrayerReadingViewController()
    }
    
    // MARK: Private methods
    
    private func configureNavigationBar() {
        let favouriteButton = ToggleButton()
        favouriteButton.image = UIImage(named: "heartIcon")
        favouriteButton.selectedImage = UIImage(named: "heartIconSelected")
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped(_:)), for: .touchUpInside)
        let favouriteBarButton = UIBarButtonItem(customView: favouriteButton)
        navigationItem.rightBarButtonItem = favouriteBarButton
    }
    
    private func configurePrayerReadingViewController() {
        let prayerReadingViewController = PrayerReadingViewController()
        addChildController(prayerReadingViewController)
        self.prayerReadingViewController = prayerReadingViewController
    }
    
    @objc private func favouriteButtonTapped(_ favouriteButton: ToggleButton) {
        log("is selected: \(favouriteButton.isSelected)")
        favouriteButton.toggle()
    }
}
