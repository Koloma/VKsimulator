//
//  CustomPushAnimator.swift
//  VKsimulator
//
//  Created by Admin on 27.01.2021.
//

import UIKit

class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //L9 01:30:00
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0)
        
        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext),
                                delay: 0,
                                options: []){
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75){
                let translation = CGAffineTransform(translationX: -200, y: 0)
                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                source.view.transform = translation.concatenating(scale)
            }
            //l9 1:37:10 explanation
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4){
                let translation = CGAffineTransform(translationX: source.view.frame.width / 2, y: 0)
                let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
                destination.view.transform = translation.concatenating(scale)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4){
                destination.view.transform = .identity
            }
            
        } completion: { (isFinished) in
            let finishedAndNotCanceled = isFinished && !transitionContext.transitionWasCancelled
            if finishedAndNotCanceled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(isFinished)
        }
    }
}
