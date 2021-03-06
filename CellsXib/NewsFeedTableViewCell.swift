//
//  NewsFeedTableViewCell.swift
//  VKsimulator
//
//  Created by Admin on 30.01.2021.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNicLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    
    
    @IBOutlet weak var newsTextView: UITextView!
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var eyeViewImage: UIImageView!
    @IBOutlet weak var numberOfViewsLable: UILabel!
    @IBOutlet weak var referenceViewImage: UIImageView!
    
    @IBOutlet weak var numberOfLikeLable: UILabel!
    @IBOutlet weak var likeViewImage: UIImageView!
    
    static let nib = UINib(nibName: "NewsFeedTableViewCell", bundle: nil)
    static let identifier = "CellNews"
    
    
    var numberOfLike = 99
    var numberOfViews = 32
    
    typealias ImageViewTapFunc =  (VKUser) -> Void
    private var newsImageViewTap : ImageViewTapFunc?
    private var vkUser: VKUser?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configur(vkUser: VKUser, imageTapFunc: @escaping ImageViewTapFunc){
        newsImageViewTap = imageTapFunc
        self.vkUser = vkUser
        userNicLable.text = vkUser.fio
        vkUser.getImage(imageType: .image50){ image in
            DispatchQueue.main.async {
                self.userImageView.image = image
            }
        }
        numberOfLikeLable.text = String(numberOfLike)
        numberOfViewsLable.text = String(numberOfViews)
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateLable.text = dateFormatter.string(from: date)
        newsTextView.text = "news Text"
        newsImageView.image = UIImage(named: "pic1")
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        //newsTextView.adjustHeight()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        tapGesture2.numberOfTapsRequired = 1
        tapGesture2.numberOfTouchesRequired = 1

        likeViewImage.addGestureRecognizer(tapGesture)
        numberOfLikeLable.addGestureRecognizer(tapGesture2)
        
        let tapGestureNewsImage = UITapGestureRecognizer(target: self, action: #selector(newsImageViewTaped))
        tapGestureNewsImage.numberOfTapsRequired = 1
        tapGestureNewsImage.numberOfTouchesRequired = 1
        newsImageView.addGestureRecognizer(tapGestureNewsImage)

    }
    
    @objc func newsImageViewTaped(){
        guard let vkUser = vkUser else { return }
        newsImageViewTap?(vkUser)
    }
    
    @objc func likeTapped(_ sender: UIView) {
        numberOfLike += 1
        UIView.transition(with: numberOfLikeLable, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
            self.numberOfLikeLable.text = String(self.numberOfLike)
        })
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [], animations: {
            self.likeViewImage.bounds.size = CGSize(width: self.likeViewImage.bounds.width / 2, height: self.likeViewImage.bounds.height / 2)
        },completion: {_ in
            //self.gtureseLike.isEnabled = true
        })
    }
    
}
