//
//  StatusBarAppearance.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 21/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

struct StatusBarAppearance {
    var hidden: Bool
    var animation: UIStatusBarAnimation
    var style: UIStatusBarStyle
    
    static var `default` = StatusBarAppearance(hidden: false, animation: .fade, style: .default)
}

extension StatusBarAppearance {
    init(hidden: Bool, animation: UIStatusBarAnimation) {
        self.init(hidden: hidden, animation: animation, style: .default)
    }
}

extension StatusBarAppearance: Equatable {
    static func == (lhs: StatusBarAppearance, rhs: StatusBarAppearance) -> Bool {
        return lhs.hidden == rhs.hidden && lhs.animation == rhs.animation && lhs.style == rhs.style
    }
}
