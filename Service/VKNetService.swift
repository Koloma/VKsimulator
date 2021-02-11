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
    
    
    func loadGroups(token: String) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGetGroups// "/method/groups.get"
        
        let params : Parameters = [
            "access_token": token,
            "extended": 1,
            "v":K.ApiVK.v
        ]
        
        getJSON(url: baseURL + path, parametrs: params)
    }
    
    func groupsSearch(token: String, textQuery:String) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGroupsSearch// "/method/groups.get"
        
        let params : Parameters = [
            "access_token": token,
            "q":textQuery,
            "type": "group",
            "v":K.ApiVK.v
        ]
        
        getJSON(url: baseURL + path, parametrs: params)
    }
    
    func loadFriends(token: String) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGetFriends
        
        let params : Parameters = [
            "access_token": token,
            "v":K.ApiVK.v,
            "fields": "nickname, domain, sex, bdate, city, country, timezone, photo_50, photo_100, photo_200_orig, has_mobile, contacts, education, online, relation, last_seen, status, can_write_private_message, can_see_all_posts, can_post, universities"
        ]
        
        getJSON(url: baseURL + path, parametrs: params)
    }
    
    func loadUserImages(token: String, userId: Int) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGetUserAllPhotos
        
        let params : Parameters = [
            "access_token": token,
            "owner_id": userId,
            "v":K.ApiVK.v,
            "extended": 0,
            "count": 100
        ]
        
        getJSON(url: baseURL + path, parametrs: params)
    }
    
    
    
    
    private func getJSON(url: String, parametrs: Parameters){
        VKNetService.sessionAF.request(url, method: .get, parameters: parametrs).responseJSON { response in
            print(response.request!)
            switch response.result {
            case .success(let value):
                //guard let json = response.value else { return }
                print(value)

            case .failure(let error):
                print(error)
            }
        }
    }
}
