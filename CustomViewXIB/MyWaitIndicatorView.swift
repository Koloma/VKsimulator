//
//  MyWaitIndicatorView.swift
//  VKsimulator
//
//  Created by Admin on 24.01.2021.
//

import UIKit

class MyWaitIndicatorView: UIView {


    @IBOutlet var containerView: UIView!
    @IBOutlet weak var circleImage1: UIImageView!
    @IBOutlet weak var circleImage2: UIImageView!
    @IBOutlet weak var circleImage3: UIImageView!
    
    var indicatorTintColor: UIColor = UIColor.systemPink {
        didSet{
            circleImage1.tintColor = indicatorTintColor
            circleImage2.tintColor = indicatorTintColor
            circleImage3.tintColor = indicatorTintColor
        }
    }
    
    private func configureUI(){
        Bundle.main.loadNibNamed("MyWaitIndicatorView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask=[.flexibleWidth, .flexibleHeight]
        waitAnimation()
    }
    
    private func waitAnimation(){
        UIView.animate( withDuration: 0.6, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.circleImage1.alpha = 0.1
        })
        UIView.animate( withDuration: 0.6, delay: 0.2, options: [.autoreverse, .repeat], animations: {
            self.circleImage2.alpha = 0.1
        })
        UIView.animate( withDuration: 0.6, delay: 0.4, options: [.autoreverse, .repeat], animations: {
            self.circleImage3.alpha = 0.1
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    func createIndicatorWait(ownerView: UIView){
        frame = CGRect(x: (UIScreen.main.bounds.size.width - 100)/2, y: (UIScreen.main.bounds.size.height - 100)/2 + 150, width: 100, height: 100)
        addSubview(containerView)
        isHidden = true
        ownerView.addSubview(self)
        ownerView.bringSubviewToFront(self)
    }
}
