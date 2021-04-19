//
//  VKNetService.swift
//  VKsimulator
//
//  Created by Admin on 10.02.2021.
//

import UIKit
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
    
    func loadUser(by userId: Int, completion: ((Swift.Result<VKUser,Error>) -> Void)? = nil) {
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
        
 //       let request = AF.request(url)
//        request.responseJSON { (response) in
//            switch response.result{
//
//            case .success(let json):
//                print(json)
//            case .failure(let error):
//                print(error)
//            }
//
//              //  fdgfdg
////                do {
////                    let userRaw = try JSONDecoder().decode(UserRAW.self, from: data)
////                    if let users = userRaw.response.items{
////                        resolver.fulfill(users)
////                    }else{
////                        resolver.reject(MyErrors.noData)
////                    }
////                } catch {
////                    resolver.reject(error)
////                }
            
 //       }
        sharedDataTask(url: url){ data in
            let decoder = JSONDecoder()
            do{
                let responce = try decoder.decode(ResponseUserRAW.self,from: data)
                //print(responce)
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
    
    func loadGroup(by groupId: Int, completion: ((Swift.Result<VKGroup,Error>) -> Void)? = nil) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGetGroupsById
        
        let queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "group_id", value: "\(abs(groupId))"),
            URLQueryItem(name: "v", value: K.ApiVK.v)]
        
        guard var urlComps = URLComponents(string: baseURL + path) else { return }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }
        
        sharedDataTask(url: url){ data in
            let decoder = JSONDecoder()
            do{
                let responce = try decoder.decode(ResponseGroupRAW.self,from: data)
                if let group = responce.response?.first {
                    completion?(.success(group))
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
    
    func loadUserNewsfeed(newsCount: Int,
                          from item: String = "",
                          completion: ((Swift.Result<([VKNews],String),Error>) -> Void)? = nil) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGetUserNewsfeed

        let queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "owner_id", value: "\(Session.shared.userId)"),
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "\(newsCount)"),
            URLQueryItem(name: "start_from", value: item),
            URLQueryItem(name: "v", value: K.ApiVK.v)]
        
        guard var urlComps = URLComponents(string: baseURL + path) else { return }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }
        
        sharedDataTask(url: url){ data in
            let decoder = JSONDecoder()
            
            do{
                let response = try decoder.decode(VKNewsRAW.self, from: data)
                
                guard let news = response.response.items,
                      let nextFrom = response.response.nextFrom
                else {
                    print("Error Response or nextFrom")
                    completion?(.failure(MyErrors.newsfeed(msg: "Response or nextFrom")))
                    return }
                
                completion?(.success((news,nextFrom)))
                
                
            }catch(let error){
                do{
                    let eror = try decoder.decode(VKErrorRAW.self, from: data)
                    print(eror.error.errorMsg)
                }catch(let err){
                    print(err)
                    
                    completion?(.failure(error))
                }

                
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
