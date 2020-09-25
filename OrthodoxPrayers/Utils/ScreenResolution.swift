//
//  ScreenResolution.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 24/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import Foundation

enum ScreenResolution {
    /// Devices: 4" iPhone SE, 5, 5S, 5C, 6SE. Dimensions (portrait): 320pt × 568pt (640px × 1136px @2x).
    case iPhone_SE
    
    /// Devices: 4.7" iPhone SE, 6, 6s, 7, 8. Dimensions (portrait): 375pt × 667pt (750px × 1334px @2x).
    case iPhone_8
    
    /// Devices: iPhone 6+, 6S+, 7+, 8+. Dimensions (portrait): 414pt × 736pt (1080px × 1920px @3x).
    case iPhone_8_Plus
    
    /// Devices: iPhone XR, 11. Dimensions (portrait): 414pt × 896pt (828px × 1792px @2x).
    case iPhone_11
    
    /// Devices: iPhone X, XS, 11 Pro. Dimensions (portrait): 375pt × 812pt (1125px × 2436px @3x).
    case iPhone_11_Pro
    
    /// Devices: iPhone XS Max, 11 Pro Max. Dimensions (portrait): 414pt × 896pt (1242px × 2688px @3x).
    case iPhone_11_Pro_Max
}
