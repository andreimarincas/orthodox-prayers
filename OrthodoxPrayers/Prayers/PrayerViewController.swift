//
//  PrayerViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 30/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

protocol PrayerViewControllerDelegate: NSObjectProtocol {
    func didChangePrayer(_ prayer: Prayer)
}

class PrayerViewController: UIViewController {
    private var prayerReadingViewController: PrayerReadingViewController?
    weak var delegate: PrayerViewControllerDelegate?
    var prayer: Prayer?
    
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
        favouriteButton.isSelected = prayer?.isFavourite ?? false
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped(_:)), for: .touchUpInside)
        let favouriteBarButton = UIBarButtonItem(customView: favouriteButton)
        navigationItem.rightBarButtonItem = favouriteBarButton
    }
    
    @objc private func favouriteButtonTapped(_ favouriteButton: ToggleButton) {
        log("is selected: \(favouriteButton.isSelected)")
        favouriteButton.toggle()
        if let prayer = prayer {
            prayer.isFavourite = favouriteButton.isSelected
            delegate?.didChangePrayer(prayer)
        }
    }
    
    private func configurePrayerReadingViewController() {
        let prayerReadingViewController = PrayerReadingViewController.fromNib()
        addChildController(prayerReadingViewController)
        self.prayerReadingViewController = prayerReadingViewController
    }
}
