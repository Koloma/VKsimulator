//
//  CustomNavigationController.swift
//  VKsimulator
//
//  Created by Admin on 27.01.2021.
//

import UIKit
//L9 01:25:00
class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //L9 01:26:30
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .pop:
        
        case: .push:
            
        default:
            return nil
        }
    }


}
