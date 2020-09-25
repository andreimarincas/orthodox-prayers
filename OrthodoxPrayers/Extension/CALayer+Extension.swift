//
//  CALayer+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 28/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation
import QuartzCore

extension CALayer {
    func watchAnimations() {
        CALayer.checkAnimations(forLayer: self)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.15) {
            self.watchAnimations()
        }
    }
    
    static func checkAnimations(forLayer layer: CALayer) {
        for key in layer.animationKeys() ?? [] {
            let anim = layer.animation(forKey: key)
            log("[layer: \(layer)] - anim: \(String(describing: anim))")
        }
        for sublayer in layer.sublayers ?? [] {
            checkAnimations(forLayer: sublayer)
        }
    }
}
