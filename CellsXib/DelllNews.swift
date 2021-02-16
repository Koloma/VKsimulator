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
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var likeCountLable: UILabel!
    @IBOutlet weak var sendImageView: UIImageView!
    @IBOutlet weak var commentImageView: UIImageView!
    
    @IBOutlet private var widthConstraint: NSLayoutConstraint! {
        didSet {
            widthConstraint.isActive = false
        }
    }
    
    static let nib = UINib(nibName: "NewsFeedCollectionViewCell", bundle: nil)
    static let identifier = "CellNews"

    
    var likeCount = 1000
    
    func configur(user: VKUser.User, newsText: String, newsImage: [UIImage]){
        userNameLable.text = user.firstName + " " + user.lastName
        userImageView.image = nil
        likeCountLable.text = String(likeCount)
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateLable.text = dateFormatter.string(from: date)
        //newsTextView.text = newsText
        newsImageView.image = newsImage[0]
        
        adjustUITextViewHeight(arg: newsTextView)
        
//        layer.borderWidth = NewsFeedCollectionViewCell.borderWidth
//        layer.borderColor = UIColor.lightGray.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        tapGesture2.numberOfTapsRequired = 1
        tapGesture2.numberOfTouchesRequired = 1
        heartImageView.isUserInteractionEnabled = true
        likeCountLable.isUserInteractionEnabled = true
        heartImageView.addGestureRecognizer(tapGesture)
        likeCountLable.addGestureRecognizer(tapGesture2)

    }
    
    @objc func likeTapped(_ sender: UIView) {
        likeCount += 1
        UIView.transition(with: likeCountLable, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
            self.likeCountLable.text = String(self.likeCount)
        })
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [], animations: {
            self.heartImageView.bounds.size = CGSize(width: self.heartImageView.bounds.width / 2, height: self.heartImageView.bounds.height / 2)
        },completion: {_ in
            //self.gtureseLike.isEnabled = true
        })
    }
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
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
