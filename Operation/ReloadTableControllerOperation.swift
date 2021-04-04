//
//  ReloadTableControllerOperation.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 03.04.2021.
//

import UIKit

class ReloadTableControllerOperation: AsyncOperation {
    var controller: UITableView
    
    init(controller: UITableView) {
        self.controller = controller
    }
    override func main() {
        guard let parseData = dependencies.first as? ParseDataUserOperation else { return }
        
        //controller.posts = parseData.outputData
        print(parseData)
        DispatchQueue.main.async {
            self.controller.reloadData()
            print("ReloadTableControllerOperation complite")
        }

    }
    
}
