//
//  FrendsTableViewHeader.swift
//  VKsimulator
//
//  Created by Admin on 22.01.2021.
//

import UIKit

class FrendsTableViewHeader: UITableViewHeaderFooterView {

    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var label: UILabel!
    
    static let identifier = "FrendsTableViewHeader"
    static let nib = UINib(nibName: "FrendsTableViewHeader", bundle: nil)
     
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    override func draw(_ rect: CGRect) {
        let gradientLayer = CAGradientLayer()
       
        gradientLayer.colors = [K.Gradient.colorTopAlpha, K.Gradient.colorBottomAlpha]
        gradientLayer.locations = [0 as NSNumber, 1 as NSNumber]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        containView?.layer.insertSublayer(gradientLayer, at: 0)
    }

}
