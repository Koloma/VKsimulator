//
//  NetworkService.swift
//  JSON1
//
//  Created by Admin on 02.01.2021.
//

import UIKit

class NetworkService{
    
    let randomUsersURLtemplate = "https://randomuser.me/api/?results=%d"
    let notRandomUsersURLtemplate = "https://randomuser.me/api/?results=%d&seed=vksimulator"
    let randomImageURL = "https://source.unsplash.com/random/100x100"
    
    /// Запрашиваетс с сайта randomuser.me массив пользователей
    /// (т.к. в запросе используется параметр seed, массив не случайнеый)
    /// - Parameter userCount: Количество запрашиваемых пользователей
    /// - Returns: Возвращает массив пользователей
    func GetUsers(userCount:Int) ->[VKUser] {
        //performRequest(url: randomUsersURL)
        let randomUsersURL = String(format: randomUsersURLtemplate, userCount)
        guard let data = getData(url: randomUsersURL) else { return [] }
        return parseJSON(userData: data)
    }
    
    func GetImages(imageCount: Int) ->[userImage]{
        var array:[userImage] = []
        for _ in 1...imageCount{
            if let image = getImage(fromURL: randomImageURL){
                array.append(userImage(image: image, description: "No descr", likeCount: 0, isLikeSet: false))
            }
        }
        return array
    }
    
    private func parseJSON(userData: Data) -> [VKUser]{
        var usersClear:[VKUser] = []
        let decoder = JSONDecoder()
        do{
            let users = try decoder.decode(Users.self,from: userData)
            for (index, item) in users.results.enumerated() {
                var fio:String = ""
                if let name = item.name,
                   let first = name.first,
                   let last = name.last{
                    fio = first + " " + last
                }
                let description = item.gender
                let avatar = getImage(fromURL: item.picture.thumbnail)
                usersClear.append(VKUser(id: index, nicName: item.login.username, fio: fio, description: description, avatar: avatar, likeCount: 0, setLike: false))
            }
            return usersClear
        }catch{
            print("Error parseJSON \(error)")
        }
        return []
    }
    
    private func getImage(fromURL: String)->UIImage?{
        guard let data = getData(url: fromURL) else { fatalError("Error getData(url: fromURL)") }
        guard let image = UIImage(data: data) else { fatalError("Error UIImage(data: data)") }
        return image
    }
    
    private func getData(url: String)->Data?{
        guard let url = URL(string: url) else { fatalError("Error URL(string: url)") }
        do {
             let data = try Data(contentsOf: url)
            return data
        } catch {
            print(error)
        }
        //guard let data = try? Data(contentsOf: url) else { fatalError("Error Data(contentsOf: url)") }
        return nil
        
        
    }
    
}
