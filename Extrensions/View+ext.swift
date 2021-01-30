//
//  View+ext.swift
//  VKsimulator
//
//  Created by Admin on 29.01.2021.
//

import UIKit


extension UIView {
    func positionIn(view: UIView) -> CGRect {
        if let superview = superview {
            return superview.convert(frame, to: view)
        }
        return frame
    }
}
