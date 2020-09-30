//
//  UserDefaults+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 01/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func registerDefaults() {
        register(defaults: defaults)
    }
    
    private var defaults: [String : Any] {
        var defaults = [String : Any]()
        let attrs = PrayerReadingAttributes.default
        defaults["textSize"] = Float(attrs.normalFont.pointSize)
        return defaults
    }
    
    var isFavouritesSelected: Bool {
        get {
            return bool(forKey: "isFavouritesSelected")
        }
        set {
            set(newValue, forKey: "isFavouritesSelected")
            synchronize()
        }
    }
    
    var textSize: Float {
        get {
            return float(forKey: "textSize")
        }
        set {
            set(newValue, forKey: "textSize")
            synchronize()
        }
    }
}
