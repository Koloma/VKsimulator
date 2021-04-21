//
//  AsyncGroupConroller.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 21.04.2021.
//

import UIKit
import AsyncDisplayKit

final class AsyncPhotosConroller: ASDKViewController<ASDisplayNode>, ASTableDelegate, ASTableDataSource {
    
    lazy var userId = Session.shared.userId
    
    private let service = NetService.shared
    private var photos: [VKPhoto] = []
    private var tableNode: ASTableNode{
        return node as! ASTableNode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.loadUserImages(userId: userId) { [weak self] (result) in
            switch result{
            case .success(let photos):
                print("\(photos.count)")
                self?.photos = photos
                DispatchQueue.main.async {
                    self?.tableNode.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override init() {
        super.init(node: ASTableNode())
            
        self.tableNode.delegate = self
        self.tableNode.dataSource = self
        self.tableNode.allowsSelection = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let photo = photos[indexPath.row]
        let cellBlock = { () -> ASCellNode in
            return PhotoCellNode(photo: photo)
        }
        return cellBlock
    }
    
}
