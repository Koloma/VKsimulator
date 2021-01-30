//
//  MySegue.swift
//  VKsimulator
//
//  Created by Admin on 27.01.2021.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    
    override func perform() {
        guard let containerView = source.view.superview else { return }
        
        let containerFrame = containerView.frame
        let sourceFrame = CGRect(x: 0,
                                 y: -containerFrame.height,
                                 width: source.view.frame.width,
                                 height: source.view.frame.height)
        
        let destinationFrame = source.view.frame
        containerView.addSubview(destination.view)
        
        destination.view.frame = CGRect(x: 0,
                                        y: containerFrame.height,
                                        width: source.view.frame.width,
                                        height: source.view.frame.height)
        
        UIView.animate(withDuration: 0.75,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: []) {
            self.source.view.frame = sourceFrame
            self.destination.view.frame = destinationFrame
        } completion: { ( isFinished ) in
            // animated: false Иначе две анимации будут смешанны 1:05:00 9lec
            self.source.present(self.destination, animated: false, completion: nil)
            
        }
        
    }
}
