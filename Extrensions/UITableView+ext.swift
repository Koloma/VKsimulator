//
//  UITableView+ext.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 16.04.2021.
//

import UIKit

extension UITableView{
    
    func showEmptyMessage(_ message: String) {
        let label = UILabel(frame: bounds)
        label.text = message
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        
        self.backgroundView = label
    }
    
    func hideEmptyMessage() {
        self.backgroundView = nil
    }
    
}
