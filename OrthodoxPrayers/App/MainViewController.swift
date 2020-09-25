//
//  MainViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 12/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var safeAreaTopBar: UIView!
    @IBOutlet weak var safeAreaBottomBar: UIView!
    
    let hideShowSafeAreaBarsDuration = UINavigationController.hideShowBarDuration
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
        registerNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Keep safe area bars on top
        view.bringSubviewToFront(safeAreaTopBar)
        view.bringSubviewToFront(safeAreaBottomBar)
    }
    
    // MARK: Configure methods
    
    private func configureTabBarController() {
        let tabBarController = TabBarController()
        addChildController(tabBarController)
    }
    
    private func registerNotifications() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(enterFullscreen(_:)), name: .enterFullscreen)
        center.addObserver(self, selector: #selector(exitFullscreen(_:)), name: .exitFullscreen)
    }
    
    // MARK: Enter/exit fullscreen
    
    @objc private func enterFullscreen(_ notification: NSNotification) {
        setSafeAreaBarsHidden(false, animated: true)
    }
    
    @objc private func exitFullscreen(_ notification: NSNotification) {
        setSafeAreaBarsHidden(true, animated: true)
    }
    
    private func setSafeAreaBarsHidden(_ hidden: Bool, animated: Bool) {
        let duration = animated ? TimeInterval(hideShowSafeAreaBarsDuration) : 0
        let alpha: CGFloat = hidden ? 0 : 1
        UIView.animate(withDuration: duration) {
            self.safeAreaTopBar.alpha = alpha
            self.safeAreaBottomBar.alpha = alpha
        }
    }
}
