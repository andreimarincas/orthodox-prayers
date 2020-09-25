//
//  PrayersNavigationController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 27/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayersNavigationController: UINavigationController, UINavigationControllerDelegate {
    let pushAnimationDuration: TimeInterval = 0.5
    
    // MARK: Initialization
    
    init() {
        let prayersViewController = PrayersViewController.fromNib()
        super.init(rootViewController: prayersViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.delegate = self
    }
    
    // MARK: Navigation Controller Delegate
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return PushAnimationController(duration: pushAnimationDuration)
        case .pop:
            return PopAnimationController(duration: pushAnimationDuration)
        case .none:
            return nil
        @unknown default:
            logError("Unsupported navigation operation.")
            return nil
        }
    }
}
