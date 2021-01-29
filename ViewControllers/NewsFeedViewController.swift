//
//  NewsFeedViewController.swift
//  VKsimulator
//
//  Created by Admin on 19.01.2021.
//

import UIKit

class NewsFeedViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!{
        didSet{
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    
    var userNewsFeed: VKUser?{
        didSet{
            //Call function to find Users News
            //print(userNewsFeed!)           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register( NewsFeedCollectionViewCell.nib, forCellWithReuseIdentifier: NewsFeedCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

}

extension NewsFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsFeedCollectionViewCell.identifier, for: indexPath) as? NewsFeedCollectionViewCell, let vkUser = userNewsFeed{
            cell.configur(vkUser: vkUser, newsText: "Big NEWS LLLL fgcf gdbbcvxbcxvbcxvbcxvbcxvb fvbv ", newsImage: [UIImage(named: "pic1")!,UIImage(named: "pic2")!])

            //cell.width =  collectionView.bounds.width
            //-NewsFeedCollectionViewCell.spacing
            //print("collectionView.bounds.width \(collectionView.bounds.width)")
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 370, height: 700)
    }
    
}
