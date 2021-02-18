//
//  FrendCollectionViewCell.swift
//  VKsimulator
//
//  Created by Admin on 26.12.2020.
//

import UIKit

class ImageWithLikeCounterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var labelTop: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var stackViewLike: UIStackView!
    @IBOutlet private weak var labelLikeCount: UILabel!
    @IBOutlet private weak var imageLikeHeart: UIImageView!
 
    
    func configur(photo: VKPhoto.Photo){
        
        photo.getImage(imageType: .x604px) { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        labelTop.text = photo.text
        labelLikeCount.text = "\(photo.likesCount)"
        
        if  photo.isLikeSet {
            imageLikeHeart.image = UIImage(systemName: "heart.fill")
            imageLikeHeart.tintColor = UIColor.red
        }
        else {
            imageLikeHeart.image = UIImage(systemName: "heart")
            imageLikeHeart.tintColor = UIColor.white
        }
        
    }
    
    
}
