//
//  ASPhotosCollectionController.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 21.04.2021.
//

import UIKit
import AsyncDisplayKit

final class ASPhotosCollectionController: ASDKViewController<ASCollectionNode>,MosaicCollectionViewLayoutDelegate, ASCollectionDelegate, ASCollectionDataSource {
    
    private var userId: Int
    
    private let service = NetService.shared
    private var photos: [VKPhoto] = []
    private let collectionNode: ASCollectionNode
    private let layoutInspector = MosaicCollectionViewLayoutInspector()
    private let imageType: VKPhoto.ImageType = .x

    private var sections = [[VKPhoto]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.loadUserImages(userId: userId) { [weak self] (result) in
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
    
    init(userId: Int) {
        let layout = MosaicCollectionViewLayout()
        layout.numberOfColumns = 3;
        layout.headerHeight = 14;
        collectionNode = ASCollectionNode(frame: CGRect.zero, collectionViewLayout: layout)
        
        self.userId = userId
        
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
            return PhotoCellNode(photo: photo, imageType: self.imageType)
        }
        return cellBlock
    }
       
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
      return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: MosaicCollectionViewLayout, originalItemSizeAtIndexPath: IndexPath) -> CGSize {
        return sections[originalItemSizeAtIndexPath.section][originalItemSizeAtIndexPath.item].getSize(imageType: imageType)
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
      return sections.count
    }
}
