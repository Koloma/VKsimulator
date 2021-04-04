//
//  ParseDataUserOperation.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 03.04.2021.
//

import Foundation
import SwiftyJSON

class ParseDataUserOperation: AsyncOperation{
    
    var outputData: [VKUser] = []
    
   
    override func main(){
        
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data else { return }
        
        let decoder = JSONDecoder()
        do{
            let responce = try decoder.decode(UserRAW.self,from: data)
            if let users = responce.response.items{
                outputData = users
                print("ParseDataUserOperation complite")
            }
            
        }catch(let error){
            print(error)
        }
        self.state = .finished
    }
}
