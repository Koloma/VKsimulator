//
//  CustomNavigationController.swift
//  VKsimulator
//
//  Created by Admin on 27.01.2021.
//

import UIKit
//L9 01:25:00
class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    let interactiveTransition = MyIteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //L9 01:26:30
        delegate = self
        
        view.backgroundColor = UIColor.yellow
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .pop:
            print("POP")
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
            
            return CustomPopAnimator(animationType: .new)
        case .push:
            interactiveTransition.viewController = toVC
            print("PUSH")
            return CustomPushAnimator(animationType: .new)
        default:
            return nil
        }
    }


}
