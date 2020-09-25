//
//  PrayersViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 23/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayersViewController: UIViewController, PrayersTableDelegate {
    @IBOutlet weak var noFavouritesLabel: UILabel!
    private var prayersTableViewController: PrayersTableViewController?
    var needsTableViewUpdate = false
    
    private var favouritesOnly: Bool = false {
        didSet {
            UserDefaults.isFavouritesSelected = favouritesOnly
        }
    }
    
    // MARK: Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        favouritesOnly = UserDefaults.isFavouritesSelected
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noFavouritesLabel.text = "Nu ai salvat nici o rugăciune la favorite" // TODO: Localize
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
        let dataSource = favouritesOnly ? FavouritePrayersDataSource() : PrayersTableDataSource()
        prayersTableViewController?.updateTableView(data: dataSource, animated: animated)
        noFavouritesLabel.isHidden = !(favouritesOnly && dataSource.isEmpty)
    }
    
    private func configureFavouritesControl() {
        let favouritesControl = FavouritesControl()
        favouritesControl.selectedSegmentIndex = favouritesOnly ? 1 : 0
        favouritesControl.addTarget(self, action: #selector(favouritesSelectionChanged(_:)), for: .valueChanged)
        navigationItem.titleView = favouritesControl
    }
    
    @objc private func favouritesSelectionChanged(_ favouritesControl: FavouritesControl) {
        log("selected index: \(favouritesControl.selectedSegmentIndex)")
        favouritesOnly = favouritesControl.selectedSegmentIndex == 1
        updateTableView(animated: true)
    }
    
    private func configureBackButton() {
        let backButton = UIBarButtonItem(title: "ÎNAPOI", style: .plain, target: nil, action: nil)
        backButton.tintColor = .navigationBarTintColor
        navigationItem.backBarButtonItem = backButton
    }
    
    // MARK: Prayers Table Delegate
    
    func didSelectPrayer(_ prayer: String, inSection section: String) {
        log("did select prayer: \(prayer)")
        let parser = PrayersContentsParser.shared
        guard let isDetailedItem = parser.isDetailedItem(prayerItem: prayer, inSection: section) else {
            logError("Couldn't find prayer: \(prayer) in section: \(section)")
            return
        }
        if isDetailedItem {
            let prayersDetailsViewController = PrayersDetailsViewController.fromNib()
            prayersDetailsViewController.prayer = prayer
            prayersDetailsViewController.section = section
            prayersDetailsViewController.favouritesOnly = favouritesOnly
            navigationController?.pushViewController(prayersDetailsViewController, animated: true)
        } else {
            let prayerViewController = PrayerViewController.fromNib()
            prayerViewController.prayer = Prayer(title: prayer)
            navigationController?.pushViewController(prayerViewController, animated: true)
        }
    }
}
