//
//  NewsFeedTableViewCell.swift
//  VKsimulator
//
//  Created by Admin on 30.01.2021.
//

import UIKit

final class NewsFeedTableViewCell: UITableViewCell {
    
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
    
    
    typealias ImageViewTapFunc =  (VKNews) -> Void
    private var newsImageViewTap : ImageViewTapFunc?
    private var numberOfLike = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configur(vkNews: VKNews, imageTapFunc: @escaping ImageViewTapFunc){
        
        NetService.shared.loadUser(userId: vkNews.sourceID){ results in
            switch results{
            case .success(let user):
                DispatchQueue.main.async {
                    self.userNicLable.text = user.fio
                }
                user.getImage(imageType: .image50, completion: { [weak self] (image) in
                    DispatchQueue.main.async {
                        self?.userImageView.image = image
                    }
                })
            case .failure(let error):
                print(error)
                
            }
        }
        
        newsImageViewTap = imageTapFunc
 
        vkNews.getImage(){ images in
            DispatchQueue.main.async {
                self.newsImageView.image = images[0]
            }
        }
        
        numberOfLike = vkNews.likes?.count ?? 0
        numberOfLikeLable.text = String(numberOfLike)
        numberOfViewsLable.text = String(vkNews.views?.count ?? 0)
        
        let date = Date(timeIntervalSince1970: vkNews.date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateLable.text = dateFormatter.string(from: date)
        newsTextView.text = vkNews.text ??  "News not loaded"
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
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
//        guard let vkUser = vkUser else { return }
//        newsImageViewTap?(vkUser)
    }
    
    @objc func likeTapped(_ sender: UIView) {
        UIView.transition(with: numberOfLikeLable, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
            self.numberOfLikeLable.text = String(self.numberOfLike + 1)
        })
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [], animations: {
            self.likeViewImage.bounds.size = CGSize(width: self.likeViewImage.bounds.width / 2, height: self.likeViewImage.bounds.height / 2)
        },completion: {_ in
            //self.gtureseLike.isEnabled = true
        })
    }
    
}
