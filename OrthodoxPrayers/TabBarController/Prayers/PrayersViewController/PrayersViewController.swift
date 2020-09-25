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
    var needsTableViewUpdate = false
    
    private var favouritesOnly: Bool {
        didSet {
            UserDefaults.isFavouritesSelected = favouritesOnly
        }
    }
    
    // MARK: Initialization
    
    init() {
        self.favouritesOnly = UserDefaults.isFavouritesSelected
        super.init(nibName: "PrayersViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noFavouritesLabel.text = "Nu ai salvat nicio rugăciune la favorite" // TODO: Localize
        configureFavouritesControl()
        configureBackButton()
        configurePrayersTableViewController()
        updateTableView(animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if needsTableViewUpdate {
            updateTableView(animated: true)
            needsTableViewUpdate = false
        }
    }
    
    // MARK: Private methods
    
    private func configurePrayersTableViewController() {
        let prayersTableViewController = PrayersTableViewController.fromNib()
        prayersTableViewController.delegate = self
        addChildController(prayersTableViewController)
        self.prayersTableViewController = prayersTableViewController
    }
    
    private func updateTableView(animated: Bool) {
        let dataSource = favouritesOnly ? FavouritePrayersDataSource(parser: .shared) : PrayersTableDataSource(parser: .shared)
        prayersTableViewController.updateTableView(data: dataSource, animated: animated)
        noFavouritesLabel.isHidden = !(favouritesOnly && dataSource.isEmpty)
    }
    
    private func configureFavouritesControl() {
        let favouritesControl = SegmentedControl()
        favouritesControl.padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        favouritesControl.insertSegment(withTitle: "Toate", at: 0, animated: false)
        favouritesControl.insertSegment(withTitle: "Favorite", at: 1, animated: false)
        favouritesControl.selectedSegmentIndex = favouritesOnly ? 1 : 0
        favouritesControl.addTarget(self, action: #selector(favouritesSelectionChanged(_:)), for: .valueChanged)
        navigationItem.titleView = favouritesControl
    }
    
    @objc private func favouritesSelectionChanged(_ favouritesControl: SegmentedControl) {
        log("selected index: \(favouritesControl.selectedSegmentIndex)")
        favouritesOnly = favouritesControl.selectedSegmentIndex == 1
        updateTableView(animated: true)
    }
    
    private func configureBackButton() {
        let backButton = UIBarButtonItem(title: "ÎNAPOI", style: .plain, target: nil, action: nil)
        backButton.tintColor = .navigationBarTintColor
        navigationItem.backBarButtonItem = backButton
    }
}

// MARK: PrayersTableDelegate

extension PrayersViewController: PrayersTableDelegate {
    func didSelectPrayer(_ selectedPrayerTitle: String, inSection section: String) {
        log("did select prayer: \(selectedPrayerTitle)")
        let parser = PrayersContentsParser.shared
        guard let isDetailedItem = parser.isDetailedItem(prayerItem: selectedPrayerTitle, inSection: section) else {
            logError("Couldn't find prayer: \(selectedPrayerTitle) in section: \(section)")
            return
        }
        if isDetailedItem {
            let detailsViewController = PrayersDetailsViewController(prayer: selectedPrayerTitle, section: section, favouritesOnly: favouritesOnly)
            navigationController?.pushViewController(detailsViewController, animated: true)
        } else {
            let selectedPrayer = Prayer(title: selectedPrayerTitle)!
            let prayerViewController = PrayerViewController(prayer: selectedPrayer, parentPrayerTitle: nil, section: section)
            navigationController?.pushViewController(prayerViewController, animated: true)
        }
    }
}
