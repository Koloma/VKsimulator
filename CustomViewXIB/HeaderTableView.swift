//
//  HeaderTableView.swift
//  VKsimulator
//
//  Created by Admin on 17.01.2021.
//

import UIKit

class HeaderTableView: UITableViewHeaderFooterView {

    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
