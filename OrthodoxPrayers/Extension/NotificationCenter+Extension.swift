//
//  NotificationCenter+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 23/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

extension NotificationCenter {
    
    func addObserver(_ observer: Any, selector: Selector, name: NotificationName) {
        addObserver(observer, selector: selector, name: NSNotification.Name(name.rawValue), object: nil)
    }
    
    func post(name: NotificationName, object: Any?) {
        post(name: NSNotification.Name(name.rawValue), object: object)
    }
    
    func post(name: NotificationName) {
        post(name: NSNotification.Name(name.rawValue), object: nil)
    }
}
