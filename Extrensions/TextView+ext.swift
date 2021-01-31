//
//  TextView+ext.swift
//  VKsimulator
//
//  Created by Admin on 30.01.2021.
//

import UIKit


extension UITextView{
    func adjustHeight()
    {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
}


