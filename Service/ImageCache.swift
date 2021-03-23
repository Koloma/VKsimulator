//
//  ImageCache.swift
//  VKsimulator
//
//  Created by Admin on 16.02.2021.
//

import UIKit

final class ImageCache {
    
    static let shared = ImageCache()
    private init(){
    }
    
    private let cache = NSCache<NSURL, UIImage>()
    static let placeholderImage = UIImage(systemName: "rectangle.slash")!
    
    private func image(url: NSURL) -> UIImage? {
        return cache.object(forKey: url)
    }

    func load(url: NSURL, completion: @escaping (UIImage) -> ()) {
        if let cachedImage = image(url: url) {
            completion(cachedImage)
        }
        
        URLSession.shared.dataTask(with: url as URL) { (data, responce, error) in
            if let error = error{
                print(error)
                completion(ImageCache.placeholderImage)
            }
            
            guard let data = data else {
                completion(ImageCache.placeholderImage)
                return
            }
            
            guard let image = UIImage(data: data) else {
                print ("Error UIImage(data: data)");
                completion(ImageCache.placeholderImage)
                return
            }
            self.cache.setObject(image, forKey: url)
            completion(image)
            
        }.resume()
    }
        
//
//    private func getImage(fromURL: String)->UIImage?{
//        guard let data = getData(url: fromURL) else { print ("Error getData(url: fromURL): \(fromURL)"); return nil }
//        guard let image = UIImage(data: data) else { print ("Error UIImage(data: data)"); return nil }
//        return image
//    }
//
//    private func getData(url: String)->Data?{
//        guard let url = URL(string: url) else { print("Error URL(string: url)"); return nil }
//        do {
//             let data = try Data(contentsOf: url)
//            return data
//        } catch {
//            print("getData: \(error)")
//        }
//        return nil
//    }
    
}
