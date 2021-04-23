//
//  FrendCollectionViewCell.swift
//  VKsimulator
//
//  Created by Admin on 26.12.2020.
//

import UIKit

final class ImageWithLikeCounterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var labelTop: UILabel!
    @IBOutlet weak var imageView: AsyncImageView!
    
    @IBOutlet weak var stackViewLike: UIStackView!
    @IBOutlet private weak var labelLikeCount: UILabel!
    @IBOutlet private weak var imageLikeHeart: UIImageView!
 
    
    func configur(vkPhoto: VKPhoto, image: UIImage?){
    
        imageView.image = nil
        imageView.image = image
        labelTop.text = vkPhoto.text
        labelLikeCount.text = "\(vkPhoto.likes?.count ?? 0)"
        
        if  vkPhoto.likes?.userLikes == 1 {
            imageLikeHeart.image = UIImage(systemName: "heart.fill")
            imageLikeHeart.tintColor = UIColor.red
        }
        else {
            imageLikeHeart.image = UIImage(systemName: "heart")
            imageLikeHeart.tintColor = UIColor.white
        }
        
    }
    
    
}
