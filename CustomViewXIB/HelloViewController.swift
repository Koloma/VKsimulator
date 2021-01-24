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
    var myWaitIndicatorView = MyWaitIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeCountLable.text = String(likeCount)
        
        myWaitIndicatorView.createIndicatorWait(ownerView: self.view)
        //myWaitIndicatorView.isHid = false        
    }
       
    @IBAction func doActionButtonTaped(_ sender: UIBarButtonItem) {
        myWaitIndicatorView.isHid = !myWaitIndicatorView.isHid

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
    }

}
