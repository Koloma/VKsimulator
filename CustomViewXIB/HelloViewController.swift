//
//  HelloViewController.swift
//  VKsimulator
//
//  Created by Admin on 17.01.2021.
//

import UIKit

class HelloViewController: UIViewController {

    @IBOutlet weak var helloView: HelloView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        helloView.text = "Hi!"
    }
    

}
