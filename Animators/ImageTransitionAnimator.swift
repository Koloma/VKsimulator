//
//  ImageTransitionAnimator.swift
//  VKsimulator
//
//  Created by Admin on 30.01.2021.
//

import UIKit

final class ImageTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let animationDuration = 1.0
    var fromAvatarView: UIImageView!
    var toAvatarView: UIImageView!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from),
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
                return
        }
        
        transitionContext.containerView.addSubview(toView)
        
        guard let fromAvatarViewCopy = fromAvatarView.snapshotView(afterScreenUpdates: false),
            let toAvatarViewCopy = toAvatarView.snapshotView(afterScreenUpdates: true) else {
                return
        }

        let fromFrame = fromAvatarView.positionIn(view: fromView)
        let toFrame = toAvatarView.positionIn(view: toView)
        
        fromAvatarViewCopy.frame = fromFrame
        toAvatarViewCopy.frame = toFrame
        
        transitionContext.containerView.addSubview(fromAvatarViewCopy)
        transitionContext.containerView.addSubview(toView)
        
        fromAvatarView.isHidden = true
        toAvatarView.isHidden = true
        
        toView.alpha = 0
        
        UIView.animate(withDuration: animationDuration, animations: {
            fromAvatarViewCopy.frame = toAvatarViewCopy.frame
        }) { [weak self] completed in
            toView.alpha = 1
            self?.fromAvatarView.isHidden = false
            self?.toAvatarView.isHidden = false
            fromAvatarViewCopy.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
}

