//
//  TabBarController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 23/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureControllers()
        configureTabBar()
        self.delegate = self
    }
    
    // MARK: - Private methods
    
    private func configureControllers() {
        let prayersNavigationController = PrayersNavigationController()
        prayersNavigationController.tabBarItem = UITabBarItem(title: "Rugăciuni",
                                                              image: UIImage(named: "prayingIcon"),
                                                              tag: 0)
        let iconViewController = IconViewController.fromNib()
        iconViewController.tabBarItem = UITabBarItem(title: "Icoană",
                                                     image: UIImage(named: "candleIcon"),
                                                     tag: 1)
        let textViewController = TextViewController.fromNib()
        textViewController.tabBarItem = UITabBarItem(title: "Text",
                                                     image: UIImage(named: "textIcon"),
                                                     tag: 2)
        viewControllers = [prayersNavigationController, iconViewController, textViewController]
    }
    
    private func configureTabBar() {
        tabBar.tintColor = UIColor(named: "activeColor")
    }
    
    // MARK: - UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        log("did select view-controller: \(viewControllers!.firstIndex(of: viewController)!)")
    }
}
