//
//  HelloViewController.swift
//  VKsimulator
//
//  Created by Admin on 17.01.2021.
//

import UIKit

class ImageViwerViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
   
    public var vkUser: VKUser!
    
    private var interactiveAnimator: UIViewPropertyAnimator!
    private var imageArray:[VKPhoto] = []
    private var currentImageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(imageOnPan(_:)))
        self.view.addGestureRecognizer(panRecognizer)
      
        NetService.shared.loadUserImages(token: Session.shared.token, userId: vkUser.id){results in
            
            switch results{
            case .success(let photos):
                self.imageArray = photos
                
                self.imageArray[self.currentImageIndex].getImage(imageType: .x604px){ image in
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
          
    @objc func imageOnPan (_ recognizer: UIPanGestureRecognizer ){
        
        let translationX: CGFloat = 150.0
        let transformRight = CGAffineTransform(translationX: translationX, y: 0)
        let transformLeft = CGAffineTransform(translationX: -translationX, y: 0)
        
        let transformZoom = CGAffineTransform(scaleX: 0.8, y: 0.8)

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
            
            func animate1(left: Bool){
                let mult = left ? -1 : 1

                UIView.animateKeyframes(withDuration: 1,
                                        delay: 0,
                                        options: [.calculationModeLinear]){
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5){
                        self.view.layoutIfNeeded()
                        self.imageView.transform = CGAffineTransform(translationX: CGFloat(mult) * self.view.frame.width, y: 0)
                    }
                    UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.0){
                        self.view.layoutIfNeeded()
                        self.imageView.transform = .identity
                        self.imageView.transform = transformZoom
                    }
                    UIView.addKeyframe(withRelativeStartTime: 0.61, relativeDuration: 0.5){
                        self.view.layoutIfNeeded()
                        self.imageView.transform = .identity
                        self.imageArray[self.currentImageIndex].getImage(imageType: .x604px){ image in
                            DispatchQueue.main.async {
                                self.imageView.image = image
                            }
                        }
                    }
                }
            }
            
            func animate(left: Bool){
                let mult = left ? 1 : -1

                let animation = CABasicAnimation(keyPath: "position.x")
                animation.fromValue = imageView.layer.position.x
                animation.fromValue = imageView.layer.position.x + CGFloat(mult) * 500
                animation.duration = 1
                imageView.layer.add(animation, forKey: nil)
                self.imageArray[self.currentImageIndex].getImage(imageType: .x604px){ image in
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
            
            func animate(){

                self.imageArray[self.currentImageIndex].getImage(imageType: .x604px){ image in
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
                self.imageView.transform = transformZoom
                interactiveAnimator = UIViewPropertyAnimator(duration: 1.0,
                                                             dampingRatio: 1.0,
                                                             animations: {
                                                                self.imageView.transform = .identity
                                                             })
            }
            
            //showHideTransitionViews
            let translation = recognizer.translation(in: self.view)
            if translation.x > translationX {
                if currentImageIndex > 0{
                    currentImageIndex -= 1
                    
                    animate()
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
                    
                    animate()

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
