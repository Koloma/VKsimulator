//
//  FrendsCollectionViewController.swift
//  VKsimulator
//
//  Created by Admin on 26.12.2020.
//

import UIKit

private let cellIdentifier = "Cell"

class ImageGalleryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let imageCount = 10
    private var images:[UserImage] = [UserImage(image: UIImage(named: "pic1")!),
                                      UserImage(image: UIImage(named: "pic2")!),
                                      UserImage(image: UIImage(named: "pic3")!),
                                      UserImage(image: UIImage(named: "pic4")!),
                                      UserImage(image: UIImage(named: "pic1")!),
                                      UserImage(image: UIImage(named: "pic2")!),
                                      UserImage(image: UIImage(named: "pic3")!)]
        
    private var actiIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsersData()
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 215)
            
    }
 
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            if let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView", for: indexPath) as? CollectionHeaderView{
                view.label.text = "My CollectionHeader!"
                return view
            }
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ImageWithLikeCounterCollectionViewCell{
            cell.imageView.image = images[indexPath.row].image
            print(indexPath.row)
            cell.labelTop.text = "Description"
            
            let imageGesture = CustomTapGestureRecognizer(indexPath: indexPath, callback: didImageTap)
            cell.imageView.addGestureRecognizer(imageGesture)
            
            let gesture = CustomTapGestureRecognizer(indexPath: indexPath, callback: didTouchHeart)
            cell.stackViewLike.addGestureRecognizer(gesture)
            
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
        //showIndicator()
        //let networkService = NetworkService()
        //let queue = DispatchQueue.global(qos: .userInitiated)
        //queue.async{
        //    self.images = networkService.GetImages(imageCount: self.imageCount)

        //    DispatchQueue.main.async {
        //        self.collectionView.reloadData()
        //        self.actiIndicatorView.stopAnimating()
        //    }
        //}

    }
    
    func didTouchHeart(indexPath : IndexPath){
            if !images[indexPath.row].isLikeSet{
                images[indexPath.row].isLikeSet = true;
                images[indexPath.row].likeCount += 1
            }
            else{
                images[indexPath.row].isLikeSet = false;
                images[indexPath.row].likeCount -= 1
            }
            self.collectionView.reloadItems(at: [indexPath])
    }
    
    func didImageTap(indexPath : IndexPath){
        print("Image Taped \(indexPath)")
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ImageWithLikeCounterCollectionViewCell{
            
            //let fromAvatarView: UIImageView = cell.imageView
            let toAvatarView: UIImageView = UIImageView()
            toAvatarView.image = cell.imageView.image
            
            toAvatarView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(toAvatarView)
            toAvatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            toAvatarView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            toAvatarView.transform  = CGAffineTransform(scaleX: 2.0, y: 2.0)
            toAvatarView.isHidden = true
            
            
            let imageView = UIImageView(frame: cell.imageView.frame)
            let imagePosition = cell.imageView.positionIn(view: view)
            print("imagePosition \(imagePosition)")
            view.addSubview(imageView)
            imageView.frame = imagePosition
            imageView.image = images[indexPath.row].image
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            
            //view.bringSubviewToFront(imageView)
            
            UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: [], animations: {
                imageView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
                imageView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
                imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
                imageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
                
                //imageView.transform  = CGAffineTransform(scaleX: 2.0, y: 2.0)
                imageView.center = self.view.frame.center
            },completion: { _ in
                imageView.removeFromSuperview()
                self.performSegue(withIdentifier: "toImageViewer", sender: self)
            })
            
        }

    }
}

final class CustomTapGestureRecognizer: UITapGestureRecognizer {
    private let callback: (_ indexPath : IndexPath) -> Void
    var indexPath: IndexPath
    
    public init(indexPath: IndexPath, callback: @escaping (_ indexPath : IndexPath) -> Void) {
        self.callback = callback
        self.indexPath = indexPath
        super.init(target: nil, action: nil)
        
        addTarget(self, action: #selector(invokeCallback))
    }
    
    @objc private func invokeCallback() {
        callback(indexPath)
    }
}

