//
//  CustomPopAnimator.swift
//  VKsimulator
//
//  Created by Admin on 28.01.2021.
//

import UIKit

class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    internal init(animationType: CustomPushAnimator.AnimationType) {
        self.animationType = animationType
    }
    
    private let animationType : CustomPushAnimator.AnimationType
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //L9 01:30:00
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        //transitionContext.containerView.sendSubviewToBack(destination.view)
        
        destination.view.frame = source.view.frame
        
        switch animationType {
        case .new:
            let transform = CGAffineTransform(translationX: -source.view.frame.height * 3 / 4 ,
                                              y: -source.view.frame.height / 2  + source.view.frame.width / 2)
            let rotation = CGAffineTransform(rotationAngle: 1.57)
            destination.view.transform = rotation.concatenating(transform)
            
            AnimationTypeNew90(duration: transitionDuration(using: transitionContext), sourceView: source.view, destinationView: destination.view,
                               transitionContext: transitionContext, sourceViewController: source)
        case .old:
            //L9 01:43:15
            let translation = CGAffineTransform(translationX: -200, y: 0)
            let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
            destination.view.transform = translation.concatenating(scale)
            
            AnimationTypeOld(duration: transitionDuration(using: transitionContext), sourceView: source.view, destinationView: destination.view,
                             transitionContext: transitionContext, sourceViewController: source)
        }
    }
    
    private func AnimationTypeNew90(duration: TimeInterval, sourceView: UIView, destinationView: UIView,
                                    transitionContext: UIViewControllerContextTransitioning, sourceViewController :UIViewController){
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0,
                                options: []){
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75){
                let transform = CGAffineTransform(translationX: sourceView.frame.height * 3 / 4 ,
                                                  y: -sourceView.frame.height / 2  + sourceView.frame.width / 2)
                let rotation = CGAffineTransform(rotationAngle: -1.57)
                sourceView.transform = rotation.concatenating(transform)
            }

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75){
                destinationView.transform = .identity
            }
            
        } completion: { (isFinished) in
            let finishedAndNotCanceled = isFinished && !transitionContext.transitionWasCancelled
            if finishedAndNotCanceled {
                sourceViewController.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destinationView.transform = .identity
            }
            transitionContext.completeTransition(isFinished)
        }
    }
    
    private func AnimationTypeOld(duration: TimeInterval, sourceView: UIView, destinationView: UIView,
                                  transitionContext: UIViewControllerContextTransitioning, sourceViewController: UIViewController){

        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext),
                                delay: 0,
                                options: []){
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4 ){
                let translation = CGAffineTransform(translationX: sourceView.frame.width / 2, y: 0)
                let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
                sourceView.transform = translation.concatenating(scale)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.4){
                sourceView.transform = CGAffineTransform(translationX: sourceView.frame.width, y: 0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75){
                destinationView.transform = .identity
            }
            
        } completion: { (isFinished) in
            let finishedAndNotCanceled = isFinished && !transitionContext.transitionWasCancelled
            if finishedAndNotCanceled {
                sourceViewController.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destinationView.transform = .identity
            }
            transitionContext.completeTransition(isFinished)
        }
    }
    
}
