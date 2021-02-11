//
//  VKNetService.swift
//  VKsimulator
//
//  Created by Admin on 10.02.2021.
//

import UIKit
import Alamofire

class VKNetService{
    
    private static let sessionAF : Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        let session = Alamofire.Session(configuration: configuration)
        return session
    }()
    
    
    static let shared = VKNetService()
    
    private init(){
        
    }
    
    
    func loadGroups(token: String){
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params : Parameters = [
            "access_token": token,
            "extended": 1,
            "v":"5.92"
        ]
        
        VKNetService.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { response in
            guard let json = response.value else { return }
            print("Groups: \(json)")
        }
        
    }
    
}
