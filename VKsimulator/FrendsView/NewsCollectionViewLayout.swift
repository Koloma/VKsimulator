//
//  NewsCollectionViewLayout.swift
//  VKsimulator
//
//  Created by Admin on 21.01.2021.
//

import UIKit

class NewsCollectionViewLayout: UICollectionViewLayout {

    var cacheAttribute = [IndexPath:UICollectionViewLayoutAttributes]()
    var columnCount = 1
    var cellHeight: CGFloat = 700
    
    var totlaCellHeight: CGFloat = 0
    
    override func prepare() {
        self.cacheAttribute = [:]
        guard let collectionView = self.collectionView else { return }
        let itemCount = collectionView.numberOfItems(inSection: 0)
        guard  itemCount > 0 else { return  }
        
        let bigCellWidth = collectionView.frame.width
       
        let indexPath = IndexPath(item: 0, section: 0)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = CGRect(x: 0, y: 0, width: bigCellWidth, height: self.cellHeight)
        
        cacheAttribute[indexPath] = attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAttribute.values.filter{ attributes in
            return rect.intersects(attributes.frame)
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAttribute[indexPath]
    }
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: self.collectionView?.frame.width ?? 0, height: self.totlaCellHeight)
    }
}
