//
//  ReloadTableControllerOperation.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 03.04.2021.
//

import UIKit

class ReloadTableControllerOperation: AsyncOperation {
    var controller: MyFrendsViewController
    
    init(controller: MyFrendsViewController) {
        self.controller = controller
    }
    override func main() {
        guard let parseData = dependencies.first as? ParseDataUserOperation else { return }
        
        //controller.posts = parseData.outputData
        //print(parseData)
        DispatchQueue.main.async {
            self.controller.myFriends = parseData.outputData
            print("ReloadTableControllerOperation complite")
        }

    }
    
}
