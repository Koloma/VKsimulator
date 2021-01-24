//
//  MyWaitIndicatorView.swift
//  VKsimulator
//
//  Created by Admin on 24.01.2021.
//

import UIKit

class MyWaitIndicatorView: UIView {


    @IBOutlet var containerView: UIView!
    @IBOutlet var circleImage1: UIImageView!
    @IBOutlet var circleImage2: UIImageView!
    @IBOutlet var circleImage3: UIImageView!

    private var ownerView: UIView?
    private var myView: UIView = UIView()
    
    var isHid : Bool = true{
        didSet{
            if !isHid {
                myView.isHidden = false
                //ownerView?.isUserInteractionEnabled = false
                ownerView?.bringSubviewToFront(myView)
            }else{
                myView.isHidden = true
                //ownerView?.isUserInteractionEnabled = true
            }
        }
    }
    
    var text : String = "Demo wait..."
    
    
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
        self.ownerView = ownerView
        let label = UILabel.init(frame: CGRect(x: 5, y: 60, width: 90, height: 20))
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = NSTextAlignment.center
        label.text = text

        myView.frame = CGRect(x: (UIScreen.main.bounds.size.width - 100)/2, y: (UIScreen.main.bounds.size.height - 100)/2 + 150, width: 100, height: 100)

        myView.backgroundColor = UIColor.init(white: 0.0, alpha: 0.7)
        myView.layer.cornerRadius = 5
        containerView.center = CGPoint(x: myView.frame.size.width/2, y:  myView.frame.size.height/2 - 10)
        myView.addSubview(containerView)
        myView.addSubview(label)

        myView.isHidden = false
        ownerView.addSubview(myView)
    }
}
