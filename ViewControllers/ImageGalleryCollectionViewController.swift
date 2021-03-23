//
//  FrendsCollectionViewController.swift
//  VKsimulator
//
//  Created by Admin on 26.12.2020.
//

import UIKit
import RealmSwift

private let cellIdentifier = "Cell"

final class ImageGalleryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var user:VKUser!
    
    private var images:[VKPhoto] = []
    private var actiIndicatorView = UIActivityIndicatorView()
    //private var myWaitIndicatorView = MyWaitIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView")
        loadImages(vkUser:user)
    }

    
    private func loadImages(vkUser:VKUser) {
        showIndicator()
        
        NetService.shared.loadUserImages(token: Session.shared.token, userId: vkUser.id){[weak self] results in
            guard let self = self else { return }

            switch results {
            case .success(let photos):
                self.images = photos
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    RealmService.shared?.savePhotos(photos)
                    self.actiIndicatorView.stopAnimating()
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.images = RealmService.shared?.loadPhotos() ?? []
                    self.collectionView.reloadData()
                    self.actiIndicatorView.stopAnimating()
                }
            }

        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 30)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 215
        return CGSize(width: collectionView.bounds.size.width / 2, height: CGFloat(height))
        //return CGSize(width: 170, height: 215)

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
            cell.configur(photo: images[indexPath.row])
            
            let imageGesture = CustomTapGestureRecognizer(indexPath: indexPath, callback: didImageTap)
            cell.imageView.addGestureRecognizer(imageGesture)
            
            let gesture = CustomTapGestureRecognizer(indexPath: indexPath, callback: didTouchHeart)
            cell.stackViewLike.addGestureRecognizer(gesture)
            
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

    func didTouchHeart(indexPath : IndexPath){
        try? RealmService.shared?.myRealm.write({
            if images[indexPath.row].likes?.userLikes == 0{
                images[indexPath.row].likes?.userLikes = 1;
                images[indexPath.row].likes?.count += 1
            }
            else{
                images[indexPath.row].likes?.userLikes = 0;
                images[indexPath.row].likes?.count -= 1
            }
        })

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
            //print("imagePosition \(imagePosition)")
            view.addSubview(imageView)
            imageView.frame = imagePosition
            images[indexPath.row].getImage(imageType: .x604px){ image in
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }

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
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                if  let imageViwer = storyBoard.instantiateViewController(withIdentifier: "ImageViwerViewController") as? ImageViwerViewController{
                    imageViwer.vkUser = self.user
                    self.navigationController!.pushViewController(imageViwer, animated: true)
                }
                
//                self.performSegue(withIdentifier: "toImageViewer", sender: self.images[indexPath.row])
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

