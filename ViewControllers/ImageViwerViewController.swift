//
//  HelloViewController.swift
//  VKsimulator
//
//  Created by Admin on 17.01.2021.
//

import UIKit

class ImageViwerViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
   
    var interactiveAnimator: UIViewPropertyAnimator!
   
    let imageArray:[UIImage] = [UIImage(named: "pic1")!,
                                UIImage(named: "pic2")!,
                                UIImage(named: "pic3")!,
                                UIImage(named: "pic4")!]
    var currentImageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(imageOnPan(_:)))
        self.view.addGestureRecognizer(panRecognizer)
      
        imageView.image = imageArray[currentImageIndex]
    }
          
    @objc func imageOnPan (_ recognizer: UIPanGestureRecognizer ){
        
        let translationX: CGFloat = 150.0
        let transformRight = CGAffineTransform(translationX: translationX, y: 0)
        let transformLeft = CGAffineTransform(translationX: -translationX, y: 0)
        
        let transformZoomRight = CGAffineTransform(scaleX: 0.8, y: 0.8)
        let transformZoomLeft = CGAffineTransform(scaleX: 0.8, y: 0.8)

        switch recognizer.state {
        case .began:
            interactiveAnimator?.startAnimation()
            let vel = recognizer.velocity(in: self.imageView)
            if vel.x > 0 {
                //print("right")
                interactiveAnimator = UIViewPropertyAnimator(duration: 0.7,
                                                             dampingRatio: 1.5,
                                                             animations: {
                                                                self.imageView.transform = transformRight
                                                             })
            }
            else {
                interactiveAnimator = UIViewPropertyAnimator(duration: 0.7,
                                                             dampingRatio: 1.5,
                                                             animations: {
                                                                self.imageView.transform = transformLeft
                                                             })
                //print("left")
            }
            
            interactiveAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: self.view)
            
            interactiveAnimator.fractionComplete = abs(translation.x / 100)
        case .ended:
            interactiveAnimator.stopAnimation(true)
            
            let translation = recognizer.translation(in: self.view)
            if translation.x > translationX {
                if currentImageIndex > 0{
                    currentImageIndex -= 1
                    imageView.image = imageArray[currentImageIndex]
                    self.imageView.transform = transformZoomRight
                    interactiveAnimator = UIViewPropertyAnimator(duration: 1.0,
                                                                 dampingRatio: 1.0,
                                                                 animations: {
                                                                    self.imageView.transform = .identity
                                                                 })
                }
                //print("right ended")
            }else{
                interactiveAnimator.addAnimations {
                    self.imageView.transform = .identity
                }
            }
            if translation.x < -translationX {
                if currentImageIndex < imageArray.count-1{
                    currentImageIndex += 1
                    imageView.image = imageArray[currentImageIndex]
                    self.imageView.transform = transformZoomLeft
                    interactiveAnimator = UIViewPropertyAnimator(duration: 1.0,
                                                                 dampingRatio: 1.0,
                                                                 animations: {
                                                                    self.imageView.transform = .identity
                                                                 })
                }
                
                //print("left ended")
            }else{
                interactiveAnimator.addAnimations {
                    self.imageView.transform = .identity
                }
            }
            interactiveAnimator.startAnimation()
            
        default:
            return
        }
    }
    
}
