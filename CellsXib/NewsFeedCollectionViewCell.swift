//
//  VKUserCollectionViewCell.swift
//  VKsimulator
//
//  Created by Admin on 21.01.2021.
//

import UIKit

class NewsFeedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var newsTextView: UITextView!
    @IBOutlet weak var newsImageView: UIImageView!
    
    
    static let nib = UINib(nibName: "NewsFeedCollectionViewCell", bundle: nil)
    static let identifier = "CellNews"
    
    
    func configur(vkUser: VKUser, newsText: String, newsImage: [UIImage]){
        userNameLable.text = vkUser.fio
        userImageView.image = vkUser.avatar
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateLable.text = dateFormatter.string(from: date)
        //newsTextView.text = newsText
        newsImageView.image = newsImage[0]
       
    }
}
