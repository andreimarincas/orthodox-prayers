//
//  TabBarController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 22/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    let hideShowTabBarDuration = UINavigationController.hideShowBarDuration
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        configureTabBar()
    }
    
    // MARK: Configure methods
    
    private func configureViewControllers() {
        let prayersNavigationController = PrayersNavigationController()
        let prayersTabItem = UITabBarItem(title: "Rugăciuni", image: UIImage(named: "prayingIcon"), tag: 0)
        prayersNavigationController.tabBarItem = prayersTabItem
        
        let iconViewController = IconViewController()
        let iconTabItem = UITabBarItem(title: "Icoană", image: UIImage(named: "candleIcon"), tag: 1)
        iconViewController.tabBarItem = iconTabItem
        
        let textViewController = TextViewController()
        let textTabItem = UITabBarItem(title: "Text", image: UIImage(named: "textIcon"), tag: 2)
        textViewController.tabBarItem = textTabItem
        
        viewControllers = [prayersNavigationController, iconViewController, textViewController]
    }
    
    private func configureTabBar() {
        tabBar.tintColor = .activeColor
        tabBar.unselectedItemTintColor = .tabBarItemUnselectedColor
    }
    
    // MARK: Layout updates
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Keep tab bar in the preferred position
        if isTabBarHidden {
            tabBar.frame = preferredTabBarFrame
        }
    }
    
    // MARK: Hide/show tab bar
    
    private(set) var isTabBarHidden = false
    
    private var preferredTabBarFrame: CGRect {
        var y = view.frame.height
        if !isTabBarHidden {
            y -= tabBar.frame.height
        }
        return CGRect(x: 0, y: y, width: view.frame.width, height: tabBar.frame.height)
    }
    
    func setTabBarHidden(_ hidden: Bool, animated: Bool) {
        guard hidden != isTabBarHidden else { return }
        isTabBarHidden = hidden
        let duration = animated ? TimeInterval(hideShowTabBarDuration) : 0
        let frame = preferredTabBarFrame
        UIView.animate(withDuration: duration) {
            self.tabBar.frame = frame
            self.updateChildrenSafeAreaInsets()
        }
    }
    
    private func updateChildrenSafeAreaInsets() {
        for childViewController in children {
            var insets = childViewController.additionalSafeAreaInsets
            insets.bottom = isTabBarHidden ? -tabBar.frame.height : 0
            childViewController.additionalSafeAreaInsets = insets
        }
    }
}
