//
//  FrendsCollectionViewController.swift
//  VKsimulator
//
//  Created by Admin on 26.12.2020.
//

import UIKit

private let cellIdentifier = "Cell"

class FrendsCollectionViewController: UICollectionViewController {

    private let imageCount = 10
    private var images:[userImage] = []
    private var actiIndicatorView = UIActivityIndicatorView()
//    private let gestureRecognizerHeartTouch = UIGestureRecognizer(target: self, action: #selector(didTouchHeart))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsersData()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? FrendCollectionViewCell{
            cell.imageView.image = images[indexPath.row].image
            //cell.imageView.rounded()
            //cell.imageView.applyshadowWithCorner(containerView: cell.containerImageView)
            cell.labelTop.text = "Description"
            
            let gesture = CustomTapGestureRecognizer(target: self, action: #selector(didTouchHeart))
            gesture.indexPath = indexPath
            cell.imageLikeHeart.addGestureRecognizer(gesture)
            cell.imageLikeHeart.isUserInteractionEnabled = true
            cell.labelLikeCount.text = String(images[indexPath.row].likeCount)
            if images[indexPath.row].isLikeSet {
                cell.imageLikeHeart.image = UIImage(systemName: "heart.fill")
                cell.imageLikeHeart.tintColor = UIColor.red
            }
            else {
                cell.imageLikeHeart.image = UIImage(systemName: "heart")
                cell.imageLikeHeart.tintColor = UIColor.white
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func showIndicator(){
        actiIndicatorView.center = self.view.center
        actiIndicatorView.hidesWhenStopped = true
        actiIndicatorView.style = UIActivityIndicatorView.Style.large
        view.addSubview(actiIndicatorView)
        actiIndicatorView.startAnimating()
    }
    
    private func loadUsersData() {
        showIndicator()
        let networkService = NetworkService()
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async{
            self.images = networkService.GetImages(imageCount: self.imageCount)

            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.actiIndicatorView.stopAnimating()
            }
        }
    }
    
    @objc func didTouchHeart(_ sender: CustomTapGestureRecognizer){
        if let indexPath = sender.indexPath {
            if !images[indexPath.row].isLikeSet{
                images[indexPath.row].isLikeSet = true;
                images[indexPath.row].likeCount += 1
            }
            else{
                images[indexPath.row].isLikeSet = false;
                images[indexPath.row].likeCount -= 1
            }
            
            self.collectionView.reloadData()
        }
    }

}

class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var indexPath: IndexPath?
}
