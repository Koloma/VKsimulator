//
//  FrendsCollectionViewController.swift
//  VKsimulator
//
//  Created by Admin on 26.12.2020.
//

import UIKit

private let reuseIdentifier = "Cell"

class FrendsCollectionViewController: UICollectionViewController {

    private var frends:[VKUser] = []
    
    private var actiIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsersData()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return frends.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FrendCollectionViewCell{
            cell.imageView.image = frends[indexPath.row].avatar
            cell.imageView.rounded()
            cell.labelTop.text = frends[indexPath.row].nicName
            cell.labelBottom.text = frends[indexPath.row].fio ?? ""
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
    
    func loadUsersData() {
        showIndicator()
        let networkService = NetworkService()
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async{
            self.frends = networkService.GetUsers(userCount: 5)

            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.actiIndicatorView.stopAnimating()
            }
        }
    }

}
