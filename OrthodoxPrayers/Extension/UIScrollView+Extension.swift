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
    
    /// Hides the vertical scroll indicator if currently visible but keeps the visibility setting, i.e. showsVerticalScrollIndicator remains the same.
    func hideVerticalScrollIndicator() {
        let shows = showsVerticalScrollIndicator
        showsVerticalScrollIndicator = false
        showsVerticalScrollIndicator = shows
    }
    
    var maximumContentOffset: CGPoint {
        let adjustedContentSize = contentSize.outsetBy(contentInset)
        let x = max(adjustedContentSize.width - frame.width, 0)
        let y = max(adjustedContentSize.height - frame.height, 0)
        return CGPoint(x: x, y: y)
    }
}
