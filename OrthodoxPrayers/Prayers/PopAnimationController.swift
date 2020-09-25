//
//  PopAnimationController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 28/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PopAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval
    
    init(duration: TimeInterval) {
        self.duration = duration
    }
    
    // MARK: View-Controller Animated Transitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
        // Calculate start/end frames
        var fromViewEndFrame = fromView.frame
        fromViewEndFrame.origin.x += fromView.frame.width
        var toViewStartFrame = fromView.frame
        toViewStartFrame.origin.x -= fromView.frame.width / 3
        let toViewEndFrame = fromView.frame
        // Prepare for transition
        transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        toView.frame = toViewStartFrame
        toView.alpha = 0
        // Animate transition
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 500,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
        animations: {
            fromView.frame = fromViewEndFrame
            fromView.alpha = 0
            toView.frame = toViewEndFrame
            toView.alpha = 1
        }, completion: { _ in
            let cancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!cancelled)
        })
    }
}
