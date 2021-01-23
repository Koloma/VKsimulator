//
//  HelloViewController.swift
//  VKsimulator
//
//  Created by Admin on 17.01.2021.
//

import UIKit

class HelloViewController: UIViewController {

    @IBOutlet weak var circle1Image: UIImageView!
    @IBOutlet weak var circle2Image: UIImageView!
    @IBOutlet weak var circle3Image: UIImageView!
    @IBOutlet weak var vkLableImage: UIImageView!
    @IBOutlet weak var likeCountLable: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var gtureseLike: UITapGestureRecognizer!
    
    var likeCount = 10;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeCountLable.text = String(likeCount)
        
        waitAnimation()
    }
    
    func waitAnimation(){
        UIView.animate( withDuration: 0.6, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.circle1Image.alpha = 0.1
        })
        UIView.animate( withDuration: 0.6, delay: 0.2, options: [.autoreverse, .repeat], animations: {
            self.circle2Image.alpha = 0.1
        })
        UIView.animate( withDuration: 0.6, delay: 0.4, options: [.autoreverse, .repeat], animations: {
            self.circle3Image.alpha = 0.1
        })
    }
    
    @IBAction func doActionButtonTaped(_ sender: UIBarButtonItem) {
          

    }
    
    @IBAction func likeTapped(_ sender: UITapGestureRecognizer) {
        gtureseLike.isEnabled = false
        likeCount += 1
        UIView.transition(with: likeCountLable, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
            self.likeCountLable.text = String(self.likeCount)
        })
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [], animations: {
            self.heartImageView.bounds.size = CGSize(width: self.heartImageView.bounds.width / 2, height: self.heartImageView.bounds.height / 2)
        },completion: {_ in
            self.gtureseLike.isEnabled = true
        })
        
    }
    
    @IBAction func lableTaped(_ sender: UITapGestureRecognizer) {
        let bounds = self.vkLableImage.bounds.size
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [], animations: {
            self.vkLableImage.bounds.size = CGSize(width: bounds.width + bounds.width / 4, height: bounds.height + bounds.height / 4)
        })

//        vkLableImage.transform =
//            CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
//        UIView.animate(withDuration: 0.3 / 1.5, animations: {
//            self.vkLableImage.transform =
//                CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
//        }) { finished in
//            UIView.animate(withDuration: 0.3 / 2, animations: {
//                self.vkLableImage.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
//            }) { finished in
//                UIView.animate(withDuration: 0.3 / 2, animations: {
//                    self.vkLableImage.transform = CGAffineTransform.identity
//                })
//            }
//        }
        
    }
    
}
