//
//  SearchBarAnimator.swift
//  VKsimulator
//
//  Created by Admin on 25.01.2021.
//

import UIKit

typealias SBAnimation = (UIImageView, UITextField, UIImageView, UIView) -> Void

final class SBAnimator{
    private let animation : SBAnimation
    
    init(animation: @escaping SBAnimation) {
        self.animation = animation
    }
    
    func animate(searchImage: UIImageView, textField: UITextField, cancelImage: UIImageView, in view: UIView){
        animation(searchImage, textField, cancelImage, view)
    }
}

private func prepereView(_ searchImage: UIImageView,_ textField: UITextField, _ cancelImage: UIImageView, in view: UIView){
    searchImage.transform = CGAffineTransform(translationX: view.bounds.width / 2 - searchImage.frame.width / 2, y: 0)
    textField.transform = CGAffineTransform(translationX: view.bounds.width  + 50, y: 0)
    cancelImage.transform = CGAffineTransform(translationX: view.bounds.width  + 50, y: 0)
}

enum SBAnimationFactory {
    static func prepearSearchBar() -> SBAnimation{
        return { searchImage, textField, cancelImage, view in
            prepereView(searchImage, textField, cancelImage,in: view)
        }
    }
    
    static func makeAnimation() -> SBAnimation {
        return { searchImage, textField, cancelImage, view in
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.4,
                options: [.curveEaseInOut],
                animations: {
                    searchImage.transform = .identity
                    textField.transform = .identity
                    cancelImage.transform = .identity
                })
        }
    }
    
    static func clearAnimation() -> SBAnimation{
        return { searchImage, textField, cancelImage, view in
            
            UIView.animate(
                withDuration: 0.5,
                animations: {
                    prepereView(searchImage, textField, cancelImage,in: view)
                })
        }
    }
}
