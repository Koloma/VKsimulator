//
//  HellowView.swift
//  VKsimulator
//
//  Created by Admin on 17.01.2021.
//

import UIKit


class HelloView: UIView {
    
    var text : String?{
        didSet{
            helloLabel.text = text
        }
    }
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet var contentView: UIView!
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI(){
        Bundle.main.loadNibNamed("HelloView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask=[.flexibleWidth, .flexibleHeight]
    }
}
