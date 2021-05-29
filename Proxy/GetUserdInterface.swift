//
//  GetUserdInterface.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 29.05.2021.
//

import Foundation

protocol GetUserdInterface{
   func getUsers(by userId: Int, completion: ((Swift.Result<VKUser,Error>) -> Void)?)
}

class GetUsersFromNetProxy: GetUserdInterface {
    let getUsersFromNet: GetUsersFromNet
    
    init(getUsersFromNet: GetUsersFromNet) {
        self.getUsersFromNet = getUsersFromNet
    }
    
    func getUsers(by userId: Int, completion: ((Swift.Result<VKUser,Error>) -> Void)?){
        //Логируем запрос userId
        print("Sen log to server \(userId)")
        self.getUsers(by: userId, completion: completion)
    }

}


class GetUsersFromNet: GetUserdInterface{
    func getUsers(by userId: Int, completion: ((Result<VKUser, Error>) -> Void)?) {
        let baseURL = K.ApiVK.baseUrl
        let path = K.ApiVK.pathGetUsers
               
        let queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "user_ids", value: "\(userId)"),
            URLQueryItem(name: "fields", value: "nickname, domain, sex, bdate, city, country, timezone, photo_50, photo_100, photo_200_orig, has_mobile, contacts, education, online, relation, last_seen, status, can_write_private_message, can_see_all_posts, can_post, universities"),
            URLQueryItem(name: "v", value: K.ApiVK.v)]
        
        guard var urlComps = URLComponents(string: baseURL + path) else { return }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }
        
        sharedDataTask(url: url){ data in
            let decoder = JSONDecoder()
            do{
                let responce = try decoder.decode(ResponseUserRAW.self,from: data)
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
    
    private  func sharedDataTask(url: URL, completion: @escaping (Data) -> () ) {
        URLSession.shared.dataTask(with: url){ data, response, error in
            if let error = error {
                print(error)
            }
            if let data = data{
                completion(data)
            }
        }.resume()
    }

    
}
