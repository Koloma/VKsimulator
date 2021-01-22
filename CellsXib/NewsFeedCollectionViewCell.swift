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
    
    @IBOutlet private var widthConstraint: NSLayoutConstraint! {
        didSet {
            widthConstraint.isActive = false
        }
    }
    
    static let nib = UINib(nibName: "NewsFeedCollectionViewCell", bundle: nil)
    static let identifier = "CellNews"
    static let spacing: CGFloat = 16
    static let borderWidth: CGFloat = 0.5
    
    func configur(vkUser: VKUser, newsText: String, newsImage: [UIImage]){
        userNameLable.text = vkUser.fio
        userImageView.image = vkUser.avatar
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateLable.text = dateFormatter.string(from: date)
        //newsTextView.text = newsText
        newsImageView.image = newsImage[0]
        
        adjustUITextViewHeight(arg: newsTextView)
        
        layer.borderWidth = NewsFeedCollectionViewCell.borderWidth
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    var width: CGFloat? = nil {
        didSet {
            guard let width = width else {
                return
            }
            widthConstraint.isActive = true
            widthConstraint.constant = width
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
