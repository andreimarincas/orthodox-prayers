//
//  MainViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 12/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private var tabBarVC: TabBarController?
    @IBOutlet var imageView: UIImageView!
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userInterfaceStyleDidChange),
            name: NotificationName.userInterfaceDidChange, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUserInterfaceStyle()
    }
    
    // MARK: Private methods
    
    private func configureTabBarController() {
        let tabBarController = TabBarController()
        addChild(tabBarController)
        view.addSubviewAligned(tabBarController.view)
        tabBarController.didMove(toParent: self)
        self.tabBarVC = tabBarController
    }
    
    // MARK: Status bar style
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // MARK: UI Style
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
            updateUserInterfaceStyle()
        }
    }
    
    private func updateUserInterfaceStyle() {
        UIStyle.current = self.traitCollection.userInterfaceStyle
    }
    
    // MARK: Notification handling
    
    @objc func userInterfaceStyleDidChange() {
        log("ui style did change: \(currentStyle.rawValue)")
        updateUI()
    }
    
    private func updateUI() {
        setNeedsStatusBarAppearanceUpdate()
    }
}
