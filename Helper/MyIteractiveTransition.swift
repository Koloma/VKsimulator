//
//  MyIteractiveTransition.swift
//  VKsimulator
//
//  Created by Admin on 28.01.2021.
//

import UIKit

final class MyIteractiveTransition: UIPercentDrivenInteractiveTransition{

    var viewController : UIViewController?{
        didSet{
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenPan))
            //L9 01:57:00
            recognizer.edges = [.left, .right]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }
 
    var hasStarted = false
    var shouldFinished = false
    
    
    @objc func handleScreenPan(_ recognizer : UIScreenEdgePanGestureRecognizer){
        switch recognizer.state {
        case .began:
            hasStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1,relativeTranslation))
            print("progress \(progress)")
            //L9 02:03:00
            shouldFinished = progress > 0.33
            update(progress)
        case .ended:
            hasStarted = false
            shouldFinished ? finish() : cancel()
        case .cancelled:
            hasStarted = false
            cancel()
        default:
            return
        }
    }
    
}
