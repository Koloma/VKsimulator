//
//  SaveRealOperation.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 03.04.2021.
//

import Foundation
import Realm

class SaveRealOperation: AsyncOperation{
       
    override func main(){
        guard let parseDataUserOperation = dependencies.first as? ParseDataUserOperation else { return }
        
        RealmService.shared?.saveUsers(parseDataUserOperation.outputData)
    }
}
