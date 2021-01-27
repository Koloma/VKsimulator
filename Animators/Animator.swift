//
//  Animator.swift
//  VKsimulator
//
//  Created by Admin on 25.01.2021.
//

import UIKit

typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

final class Animator{
    private let animation : Animation
    
    init(animation: @escaping Animation) {
        self.animation = animation
    }
    
    func animate(cell: UITableViewCell, at indexPath: IndexPath,in tableView: UITableView){
        animation(cell, indexPath, tableView)
    }
}

enum AnimationFactory {
       
    static func makeAnimation() -> Animation {
        return { cell, indexPath, tableView in
            
            cell.alpha = 0
            
            UIView.animate(
                withDuration: 0.3,
                delay: 0.05, //* Double(indexPath.row),
                animations: {
                    cell.alpha = 1
                })
            
            cell.transform = CGAffineTransform(scaleX: 0.5, y: 1.0)
            
            UIView.animate(
                withDuration: 0.8,
                delay: 0.05, //* Double(indexPath.row),
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.4,
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
        }
    }
}


