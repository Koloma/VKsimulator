//
//  AnimatorVC.swift
//  VKsimulator
//
//  Created by Admin on 27.01.2021.
//

import UIKit


final class AnimatorVC: NSObject, UIViewControllerAnimatedTransitioning{
    
    let isDismissing : Bool
    
    internal init(isDismissing: Bool) {
        self.isDismissing = isDismissing
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        
        let containerFrame = transitionContext.containerView.frame
        //Начальные значения
        let sourceFrame = CGRect(x: 0,
                                 y: isDismissing ? -containerFrame.height : containerFrame.height,
                                 width: source.view.frame.width,
                                 height: source.view.frame.height)
        
        let destinationFrame = source.view.frame
        
        //Добавляем то, куда мы идем
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = CGRect(x: 0,
                                        y: isDismissing ? containerFrame.height : -containerFrame.height,
                                        width: source.view.frame.width,
                                        height: source.view.frame.width)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [],
                       animations:{
                        source.view.frame = sourceFrame
                        destination.view.frame = destinationFrame
                       }, completion: {(isFinished) in
                        transitionContext.completeTransition(isFinished)
                       })
        
    }
    
}
