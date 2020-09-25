//
//  MainViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 12/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let hideShowStatusBarDuration = UINavigationController.hideShowBarDuration
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add tab bar controller
        let tabBarController = TabBarController()
        addChildController(tabBarController)
        // Register for status bar appearance updates
        NotificationCenter.default.addObserver(self, selector: #selector(updateStatusBarAppearance), name: Notifications.needsStatusBarAppearanceUpdate, object: nil)
    }
    
    // MARK: Status bar appearance
    
    private var statusBarAppearance = StatusBarAppearance.default {
        didSet {
            if statusBarAppearance != oldValue {
                let animated = (statusBarAppearance.animation != .none)
                let duration = animated ? TimeInterval(hideShowStatusBarDuration) : 0
                UIView.animate(withDuration: duration) {
                    self.setNeedsStatusBarAppearanceUpdate()
                }
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return statusBarAppearance.hidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return statusBarAppearance.animation
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarAppearance.style
    }
    
    @objc private func updateStatusBarAppearance(_ notification: NSNotification) {
        guard let appearance = notification.userInfo?["appearance"] as? StatusBarAppearance else { return }
        statusBarAppearance = appearance
    }
}
