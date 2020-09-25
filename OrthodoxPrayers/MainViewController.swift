//
//  MainViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 12/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override var tabBarController: UITabBarController? {
        return children.first as? UITabBarController
    }
    
    var tabBar: UITabBar! {
        return tabBarController?.tabBar
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
    }
    
    // MARK: Private methods
    
    private func configureTabBarController() {
        let tabBarController = UITabBarController()
        addChildController(tabBarController)
        configureTabBar()
        configureControllers()
    }
    
    private func configureTabBar() {
        tabBar.tintColor = .activeColor
        tabBar.unselectedItemTintColor = .tabBarItemUnselectedColor
    }
    
    private func configureControllers() {
        let prayersViewController = PrayersViewController()
        let prayersNavigationController = UINavigationController(rootViewController: prayersViewController)
        let prayersTabItem = UITabBarItem(title: "Rugăciuni", image: UIImage(named: "prayingIcon"), tag: 0)
        prayersNavigationController.tabBarItem = prayersTabItem
        
        let iconViewController = IconViewController()
        let iconTabItem = UITabBarItem(title: "Icoană", image: UIImage(named: "candleIcon"), tag: 1)
        iconViewController.tabBarItem = iconTabItem
        
        let textViewController = TextViewController()
        let textTabItem = UITabBarItem(title: "Text", image: UIImage(named: "textIcon"), tag: 2)
        textViewController.tabBarItem = textTabItem
        
        tabBarController?.viewControllers = [prayersNavigationController, iconViewController, textViewController]
    }
    
    // MARK: Status bar style
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}
