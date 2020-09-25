//
//  PrayersNavigationController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 16/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayersNavigationController: UINavigationController {
    private var lastShowedViewController: UIViewController?
    
    private(set) var favouritesOnly: Bool {
        didSet {
            UserDefaults.isFavouritesSelected = favouritesOnly
        }
    }
    
    private var favouritesControl: SegmentedControl = {
        let favouritesControl = SegmentedControl()
        favouritesControl.padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        favouritesControl.insertSegment(withTitle: "Toate", at: 0, animated: false)
        favouritesControl.insertSegment(withTitle: "Favorite", at: 1, animated: false)
        favouritesControl.sizeToFit()
        return favouritesControl
    }()
    
    init() {
        favouritesOnly = UserDefaults.isFavouritesSelected
        let prayersViewController = PrayersViewController()
        super.init(rootViewController: prayersViewController)
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFavouritesControl()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if favouritesControl.superview == view {
            let navBarCenter = navigationBar.frame.origin.y + navigationBar.frame.height / 2
            favouritesControl.center = CGPoint(x: view.frame.width / 2, y: navBarCenter)
        }
    }
    
    private func configureFavouritesControl() {
        favouritesControl.selectedSegmentIndex = favouritesOnly ? 1 : 0
        favouritesControl.addTarget(self, action: #selector(favouritesSelectionChanged(_:)), for: .valueChanged)
    }
    
    @objc private func favouritesSelectionChanged(_ favouritesControl: SegmentedControl) {
        log("selected index: \(favouritesControl.selectedSegmentIndex)")
        favouritesOnly = (favouritesControl.selectedSegmentIndex == 1)
        NotificationCenter.default.post(name: Notifications.favouritesSelectionChanged, object: nil)
    }
}

// MARK: UINavigationControllerDelegate

extension PrayersNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // Keep the favourites control in the air during push/pop transitions between PrayersViewController and PrayersDetailsViewController. The case for interactive pop transition is also handled here.
        if (viewController is PrayersDetailsViewController && lastShowedViewController is PrayersViewController)
            || (viewController is PrayersViewController && lastShowedViewController is PrayersDetailsViewController) {
            navigationBar.topItem?.titleView = UIView(frame: favouritesControl.frame)
            view.addSubview(favouritesControl)
        }
        // Handle the case when the user changes his mind during interactive pop transition from PrayersDetailsViewController to PrayersViewController => The favourites control is in the air (navigationController:didShow: delegate method not called).
        transitionCoordinator?.notifyWhenInteractionChanges { [weak self] context in
            guard let self = self else { return }
            if context.isCancelled {
                let fromViewController = context.viewController(forKey: .from)
                if fromViewController is PrayersDetailsViewController {
                    fromViewController?.navigationItem.titleView = self.favouritesControl
                }
            }
        }
        // Ensure that PrayersViewController always has the favouritesControl attached to it, except for the case when returning from PrayersDetailsViewController (which is handled above). This is to cover the case for popToRootViewController from a view-controller other than PrayersDetailsViewController.
        if viewController is PrayersViewController && !(lastShowedViewController is PrayersDetailsViewController) {
            viewController.navigationItem.titleView = favouritesControl
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Put the favourites control back on the navigation bar. This is also handled in the beginning for root view controller.
        if viewController is PrayersViewController || viewController is PrayersDetailsViewController {
            navigationBar.topItem?.titleView = favouritesControl // viewController.navigationItem is the topItem here
        }
        lastShowedViewController = viewController
        if #available(iOS 14.0, *) {
            updateBackButtonMenu()
        }
    }
    
    @available(iOS 14.0, *)
    private func updateBackButtonMenu() {
        var menuItems = [UIMenuElement]()
        for navigationItem in navigationBar.items ?? [] {
            guard let backButton = navigationItem.backBarButtonItem as? BackBarButtonItem else { continue }
            guard let menuTitle = backButton.menuTitle else { continue }
            let action = UIAction(title: menuTitle) { [weak self] _ in
                guard let navigationController = self else { return }
                if let viewController = navigationController.viewControllers.first(where: { $0.navigationItem == navigationItem }) {
                    navigationController.popToViewController(viewController, animated: true)
                }
            }
            menuItems.append(action)
        }
        navigationBar.topItem?.backBarButtonItem?.menu = UIMenu(items: menuItems)
    }
}
