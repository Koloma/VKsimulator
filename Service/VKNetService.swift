//
//  VKNetService.swift
//  VKsimulator
//
//  Created by Admin on 10.02.2021.
//

import UIKit

class VKNetService{
    
//    private static let sessionAF : Alamofire.Session = {
//        let configuration = URLSessionConfiguration.default
//        configuration.allowsCellularAccess = true
//        let session = Alamofire.Session(configuration: configuration)
//        return session
//    }()
    
    static let shared = VKNetService()
    
    private init(){
        
    }
    
  
    func loadGroups(token: String, completion: @escaping ([VKGroup.Group]) -> () ) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGetGroups// "/method/groups.get"
        
        let queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: K.ApiVK.v)]
        
        guard var urlComps = URLComponents(string: baseURL + path) else { return }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }
        
        sharedDataTask(url: url){ data in
            let decoder = JSONDecoder()
            do{
                let responce = try decoder.decode(VKGroup.GroupRAW.self,from: data)
                if let groups = responce.response.items{
                    var groupsClear : [VKGroup.Group] = []
                    for group in groups {
                        groupsClear.append(VKGroup.Group(item: group))
                    }
                    completion(groupsClear)
                }

            }catch(let error){
                print(error)
            }
        }

    }
    
    func loadUsers(token: String, completion: @escaping ([VKUser.User]) -> () ) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGetFriends
               
        let queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "fields", value: "nickname, domain, sex, bdate, city, country, timezone, photo_50, photo_100, photo_200_orig, has_mobile, contacts, education, online, relation, last_seen, status, can_write_private_message, can_see_all_posts, can_post, universities"),
            URLQueryItem(name: "v", value: K.ApiVK.v)]
        
        guard var urlComps = URLComponents(string: baseURL + path) else { return }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }
        
        sharedDataTask(url: url){ data in
            let decoder = JSONDecoder()
            do{
                let responce = try decoder.decode(VKUser.UserRAW.self,from: data)
                if let friends = responce.response.items{
                    var groupsClear : [VKUser.User] = []
                    for friend in friends {
                        groupsClear.append(VKUser.User(item: friend))
                    }
                    completion(groupsClear)
                }

            }catch(let error){
                print(error)
            }
        }
    }
    
//    verified,photo_50, photo_100, photo_200_orig, photo_200, photo_400_orig,last_seen, followers_count, common_count, occupation, nickname

    func groupsSearch(token: String, textQuery:String, completion: @escaping ([VKGroup.Group]) -> () ) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGroupsSearch// "/method/groups.get"
        
        let queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "q", value: textQuery),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "v", value: K.ApiVK.v)]
        
        
        guard var urlComps = URLComponents(string: baseURL + path) else { return }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }
        
        sharedDataTask(url: url){ data in
            let decoder = JSONDecoder()
            do{
                let responce = try decoder.decode(VKGroup.GroupRAW.self,from: data)
                if let groups = responce.response.items{
                    var groupsClear : [VKGroup.Group] = []
                    for group in groups {
                        groupsClear.append(VKGroup.Group(item: group))
                    }
                    completion(groupsClear)
                }

            }catch(let error){
                print(error)
            }
        }
    }
        

    
    
    func loadUserImages(token: String, userId: Int, completion: @escaping ([VKPhoto.Photo]) -> () ) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGetUserAllPhotos
        
        let queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "owner_id", value: "\(userId)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "100"),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "skip_hidden", value: "1"),
            URLQueryItem(name: "v", value: K.ApiVK.v)]
        
        guard var urlComps = URLComponents(string: baseURL + path) else { return }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }
        
        sharedDataTask(url: url){ data in
            let decoder = JSONDecoder()
            do{
                let responce = try decoder.decode(VKPhoto.PhotoRAW.self,from: data)
                if let photos = responce.response.items{
                    var photosClear : [VKPhoto.Photo] = []
                    for photo in photos {
                        photosClear.append(VKPhoto.Photo(item: photo))
                    }
                    completion(photosClear)
                }

            }catch(let error){
                print(error)
            }
        }

    }
    
    func sharedDataTask(url: URL, completion: @escaping (Data) -> () ) {
        URLSession.shared.dataTask(with: url){ data, response, error in
            if let error = error {
                print(error)
            }
            if let response = response{
                if let httpResponse = response as? HTTPURLResponse {
                    print("httpResponse.statusCode: \(httpResponse.statusCode)")
                }
            }
            if let data = data{
                completion(data)
            }
        }.resume()
    }
    
}
