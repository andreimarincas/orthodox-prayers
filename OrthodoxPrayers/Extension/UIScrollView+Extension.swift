//
//  UIScrollView+Extension.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 13/09/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

extension UIScrollView {
    func scrollToTop(animated: Bool) {
        let offset = CGPoint(x: contentOffset.x, y: -contentInset.top)
        setContentOffset(offset, animated: animated)
    }
}
