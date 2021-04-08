//
//  VKNetService.swift
//  VKsimulator
//
//  Created by Admin on 10.02.2021.
//

import UIKit
import SwiftyJSON
import Alamofire
import PromiseKit

final class NetService{
    
    static let shared = NetService()
    
    private init(){
    }
    
    func loadGroups(completion: ((Swift.Result<[VKGroup],Error>) -> Void)? = nil) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGetGroups
        
        let queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: K.ApiVK.v)]
        
        guard var urlComps = URLComponents(string: baseURL + path) else { return }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }
        
        sharedDataTask(url: url){ data in
            let decoder = JSONDecoder()
            do{
                let responce = try decoder.decode(GroupRAW.self,from: data)
                if let groups = responce.response.items{
                    completion?(.success(groups))
                }

            }catch(let error){
                completion?(.failure(error))
            }
        }
    }
    

    
    func getUsersRequest() -> DataRequest{
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGetFriends
               
        let queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "fields", value: "nickname, domain, sex, bdate, city, country, timezone, photo_50, photo_100, photo_200_orig, has_mobile, contacts, education, online, relation, last_seen, status, can_write_private_message, can_see_all_posts, can_post, universities"),
            URLQueryItem(name: "v", value: K.ApiVK.v)]
        
        var urlComps = URLComponents(string: baseURL + path)
        urlComps?.queryItems = queryItems
        
        return AF.request(urlComps?.url ?? "")
    }
    
    func loadUsers(completion: ((Swift.Result<[VKUser],Error>) -> Void)? = nil) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGetFriends
               
        let queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "fields", value: "nickname, domain, sex, bdate, city, country, timezone, photo_50, photo_100, photo_200_orig, has_mobile, contacts, education, online, relation, last_seen, status, can_write_private_message, can_see_all_posts, can_post, universities"),
            URLQueryItem(name: "v", value: K.ApiVK.v)]
        
        guard var urlComps = URLComponents(string: baseURL + path) else { return }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }
        
        sharedDataTask(url: url){ data in
            let decoder = JSONDecoder()
            do{
                let responce = try decoder.decode(UserRAW.self,from: data)
                if let friends = responce.response.items{
                    completion?(.success(friends))
                }

            }catch(let error){
                completion?(.failure(error))
            }
        }
    }
    
    func loadUser(userId: Int, completion: ((Swift.Result<VKUser,Error>) -> Void)? = nil) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGetUsers
        
        //print("\(#function) \(userId)")
        
        let queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "user_ids", value: "\(userId)"),
            URLQueryItem(name: "fields", value: "nickname, domain, sex, bdate, city, country, timezone, photo_50, photo_100, photo_200_orig, has_mobile, contacts, education, online, relation, last_seen, status, can_write_private_message, can_see_all_posts, can_post, universities"),
            URLQueryItem(name: "v", value: K.ApiVK.v)]
        
        guard var urlComps = URLComponents(string: baseURL + path) else { return }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }
        
        let request = AF.request(url)
        
        
        request.responseJSON { (response) in
            if let error = response.error{
                print(error)
            }
            if let data = response.data{
                print(data)
                fdgfdg
//                do {
//                    let userRaw = try JSONDecoder().decode(UserRAW.self, from: data)
//                    if let users = userRaw.response.items{
//                        resolver.fulfill(users)
//                    }else{
//                        resolver.reject(MyErrors.noData)
//                    }
//                } catch {
//                    resolver.reject(error)
//                }
            }
        }
        
        sharedDataTask(url: url){ data in
            let decoder = JSONDecoder()
            do{
                let responce = try decoder.decode(ResponseUserRAW.self,from: data)
                print(responce)
                if let friends = responce.response,
                   let friend = friends.first{
                    completion?(.success(friend))
                }else{
                    completion?(.failure(MyErrors.userCouldNotBeParsed))
                }
            }catch(let error){
                completion?(.failure(error))
            }
        }
    }
    
//    verified,photo_50, photo_100, photo_200_orig, photo_200, photo_400_orig,last_seen, followers_count, common_count, occupation, nickname

    func groupsSearch(textQuery:String, completion: ((Swift.Result<[VKGroup],Error>) -> Void)? = nil) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGroupsSearch
        
        let queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "q", value: textQuery),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "v", value: K.ApiVK.v)]
        
        
        guard var urlComps = URLComponents(string: baseURL + path) else { return }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }
        
        sharedDataTask(url: url){ data in
            let decoder = JSONDecoder()
            do{
                let responce = try decoder.decode(GroupRAW.self,from: data)
                if let groups = responce.response.items{
                   completion?(.success(groups))
                }

            }catch(let error){
                completion?(.failure(error))
            }
        }
    }
    
    func loadUserImages(userId: Int, completion: ((Swift.Result<[VKPhoto],Error>) -> Void)? = nil) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGetUserAllPhotos
        
        print(#function + " UserId \(userId)")
        let queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
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
                let response = try decoder.decode(PhotoRAW.self, from: data)
                if let photos = response.response.items {
                    completion?(.success(photos))
                }

            }catch(let error){
                completion?(.failure(error))
            }
        }
    }
    
    func loadUserNewsfeed(token: String, userId: Int, completion: ((Swift.Result<[VKNews],Error>) -> Void)? = nil) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGetUserNewsfeed

        let queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "owner_id", value: "\(userId)"),
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "v", value: K.ApiVK.v)]
        
        guard var urlComps = URLComponents(string: baseURL + path) else { return }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }
        print(url)
        sharedDataTask(url: url){ data in
            
            let decoder = JSONDecoder()
            let json = JSON(data)
            let vkNewsJSONArr = json["response"]["items"].arrayValue
            let dispatchGroup = DispatchGroup()
            var vkNewsArray:[VKNews] = []
            for (index, news) in vkNewsJSONArr.enumerated() {
                DispatchQueue.global(qos: .userInteractive).async(group: dispatchGroup) {
                    do{
                        let decodeVKNews = try decoder.decode(VKNews.self, from: news.rawData())
                        print ("Decode news at index: \(index)")
                        vkNewsArray.append(decodeVKNews)
                    }catch(let errorDecode){
                        print("Decode error it index \(index): \(errorDecode)")
                        //completion?(.failure(errorDecode))
                    }
                }
            }
            
            dispatchGroup.notify(queue: DispatchQueue.main) {
                completion?(.success(vkNewsArray))
            }
        }
    }
    
    
    func sharedDataTask(url: URL, completion: @escaping (Data) -> () ) {
        URLSession.shared.dataTask(with: url){ data, response, error in
            if let error = error {
                print(error)
            }
//            if let response = response{
//                if let httpResponse = response as? HTTPURLResponse {
//                    //print("httpResponse.statusCode: \(httpResponse.statusCode)")
//                }
//            }
            if let data = data{
                completion(data)
            }
        }.resume()
    }
    
    
    func getUsersPromise() -> Promise<[VKUser]>{
        let (promise, resolver) = Promise<[VKUser]>.pending()
      
        let request = getUsersRequest()
        request.responseJSON { (response) in
            if let error = response.error{
                resolver.reject(error)
            }
            if let data = response.data{
                do {
                    let userRaw = try JSONDecoder().decode(UserRAW.self, from: data)
                    if let users = userRaw.response.items{
                        resolver.fulfill(users)
                    }else{
                        resolver.reject(MyErrors.noData)
                    }
                } catch {
                    resolver.reject(error)
                }
            }
        }
        return promise
    }
}
