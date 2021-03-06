//
//  CacheService.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 09.04.2021.
//

import UIKit
import Alamofire

final class CacheService {
    
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    
    public static let shared = CacheService()
    
    private static let pathName: String = {
        let pathName = "images"
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in:.userDomainMask).first
        else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    } ()
    
    private func getFilePath(url: String)->String? {
        guard let cachesDirectory = FileManager.default.urls(for:.cachesDirectory, in:.userDomainMask).first
        else { return nil }
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(Self.pathName + "/" + hashName).path
    }
    
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData()
        else {
            return
        }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    private func getImageFromCache(url: String) ->UIImage? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard lifeTime <= cacheLifeTime, let image = UIImage(contentsOfFile: fileName)
        else { return nil }
        
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }
    
    private var images = [String: UIImage]()
    
    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
        AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
            guard let data = response.data,
                  let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async {
                self?.images[url] = image
            }
            self?.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self?.container?.reloadRow(atIndexpath: indexPath)
            }
        }
    }

    private func loadPhoto(byUrl url: String,complition: @escaping((UIImage?)-> Void)) {
        AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
            guard let data = response.data,
                  let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async {
                self?.images[url] = image
            }
            self?.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                complition(image)
            }
        }
    }
    
    func photo(atIndexpath indexPath: IndexPath, byUrl url: String)->UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        return image
    }

    func photo(byUrl url: String, complition: ((UIImage?)-> Void)? = nil )->UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(byUrl: url){ (image) in
                complition?(image)
            }
        }
        return image
    }
    
    
private let container: DataReloadable?
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
    init() {
        self.container = nil
    }

}

fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

extension CacheService {
    
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    private class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        func reloadRow(atIndexpath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}
