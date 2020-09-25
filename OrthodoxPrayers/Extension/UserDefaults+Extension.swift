//
//  UserDefaults+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 01/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

extension UserDefaults {
    static func configure() {
        standard.register(defaults: defaults)
    }
    
    static func save() {
        standard.synchronize()
    }
    
    static var defaults: [String : Any] {
        let url = Bundle.main.url(forResource: "UserDefaults", withExtension: "plist")!
        do {
            let data = try Data(contentsOf: url)
            let root = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String: Any]
            log("\(root)")
            return root
        } catch {
            fatalError("Unresolved error: \(error)") // TODO: Handle error
        }
    }
    
    static var isFavouritesSelected: Bool {
        set {
            standard.set(newValue, forKey: "isFavouritesSelected")
            standard.synchronize()
        }
        get {
            return standard.bool(forKey: "isFavouritesSelected")
        }
    }
}
