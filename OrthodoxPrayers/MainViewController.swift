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
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
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
}
