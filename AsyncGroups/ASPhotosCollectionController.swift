//
//  ASPhotosCollectionController.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 21.04.2021.
//

import UIKit
import AsyncDisplayKit

final class ASPhotosCollectionController: ASDKViewController<ASCollectionNode>,MosaicCollectionViewLayoutDelegate, ASCollectionDelegate, ASCollectionDataSource {
    
    lazy var userId = Session.shared.userId
    
    private let service = NetService.shared
    private var photos: [VKPhoto] = []
    private let collectionNode: ASCollectionNode
    private let layoutInspector = MosaicCollectionViewLayoutInspector()

    private var sections = [[VKPhoto]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.loadUserImages(userId: userId) { [weak self] (result) in
            self?.userId
            switch result{
            case .success(let photos):
                print("\(photos.count)")
                self?.photos = photos
                
                self?.sections.append([]);
                var section = 0
                for idx in 0 ..< photos.count {
                    self?.sections[section].append(photos[idx])
                  if ((idx + 1) % 5 == 0 && idx < photos.count - 1) {
                    section += 1
                    self?.sections.append([])
                  }
                }
                
                DispatchQueue.main.async {
                    self?.collectionNode.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        collectionNode.view.isScrollEnabled = true
    }
    
    override init() {
        let layout = MosaicCollectionViewLayout()
        layout.numberOfColumns = 3;
        layout.headerHeight = 44;
        collectionNode = ASCollectionNode(collectionViewLayout: layout)

        super.init(node: collectionNode)
        layout.delegate = self
        
        self.collectionNode.delegate = self
        self.collectionNode.dataSource = self
        self.collectionNode.allowsSelection = false
        
        self.collectionNode.backgroundColor = UIColor.white
        self.collectionNode.layoutInspector = layoutInspector
        self.collectionNode.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionHeader)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let photo = sections[indexPath.section][indexPath.item]
        let cellBlock = { () -> PhotoCellNode in
            return PhotoCellNode(photo: photo)
        }
        return cellBlock
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
      return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: MosaicCollectionViewLayout, originalItemSizeAtIndexPath: IndexPath) -> CGSize {
        return CGSize(width: 100,height: 200)//sections[originalItemSizeAtIndexPath.section][originalItemSizeAtIndexPath.item].size
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
      return sections.count
    }
}

