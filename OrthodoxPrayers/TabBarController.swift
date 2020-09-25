//
//  TabBarController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 23/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureControllers()
        configureTabBar()
        self.delegate = self
    }
    
    // MARK: Private methods
    
    private func configureControllers() {
        let prayersVC = PrayersViewController.fromNib()
        prayersVC.tabBarItem = UITabBarItem(title: "Rugăciuni",
                                            image: UIImage(named: "praying-icon"),
                                            tag: 0)
        let iconVC = IconViewController.fromNib()
        iconVC.tabBarItem = UITabBarItem(title: "Icoană",
                                         image: UIImage(named: "candle-icon"),
                                         tag: 1)
        let textVC = TextViewController.fromNib()
        textVC.tabBarItem = UITabBarItem(title: "Text",
                                         image: UIImage(named: "text-icon"),
                                         tag: 2)
        viewControllers = [prayersVC, iconVC, textVC]
    }
    
    private func configureTabBar() {
        tabBar.tintColor = UIColor(named: "active-color")
    }
    
    // MARK: UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        log("did select view-controller: \(viewControllers!.firstIndex(of: viewController)!)")
    }
}
