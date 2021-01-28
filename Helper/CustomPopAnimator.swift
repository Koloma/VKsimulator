//
//  CustomPopAnimator.swift
//  VKsimulator
//
//  Created by Admin on 28.01.2021.
//

import UIKit

class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //L9 01:30:00
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        
        destination.view.frame = source.view.frame
        //destination.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0)
        
        //L9 01:43:15
        let translation = CGAffineTransform(translationX: -200, y: 0)
        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        destination.view.transform = translation.concatenating(scale)
        
        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext),
                                delay: 0,
                                options: []){
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4 ){
                let translation = CGAffineTransform(translationX: source.view.frame.width / 2, y: 0)
                let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
                source.view.transform = translation.concatenating(scale)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.4){
                source.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75){
                destination.view.transform = .identity
            }
            
        } completion: { (isFinished) in
            let finishedAndNotCanceled = isFinished && !transitionContext.transitionWasCancelled
            if finishedAndNotCanceled {
                source.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(isFinished)
        }
    }
}
