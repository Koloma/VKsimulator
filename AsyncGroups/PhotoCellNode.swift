//
//  PhotoCellNode.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 21.04.2021.
//

import Foundation
import AsyncDisplayKit

class PhotoCellNode: ASCellNode{
    
    private var photo: VKPhoto
    private var imageNode = ASNetworkImageNode()
    private var textNode = ASTextNode()
    private let imageType: VKPhoto.ImageType
    private let imageHieght: CGFloat = 200
    
    init(photo: VKPhoto,
         imageType: VKPhoto.ImageType) {
        self.photo = photo
        self.imageType = imageType
        
        super.init()
        
        setupNodes()
    }
    
    private func setupNodes(){
        imageNode.clipsToBounds = true
        
        textNode.attributedText = NSAttributedString(string: photo.text, attributes: [.font: UIFont.systemFont(ofSize: 14)])
        addSubnode(textNode)
        
        imageNode.url = URL(string: photo.getUrl(imageType: imageType))
        imageNode.contentMode = .scaleAspectFit
        addSubnode(imageNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredSize = CGSize(width: imageHieght, height: imageHieght)
        let imageSpec = ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: 10, left: 5, bottom: 10, right: 5), child: imageNode)
        
        let textSpec = ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: textNode)
        
        let verticalStackSpec = ASStackLayoutSpec()
        verticalStackSpec.direction = .vertical
        verticalStackSpec.children = [imageSpec, textSpec]
        
        return verticalStackSpec
    }
    
}
