//
//  FrendsCollectionViewController.swift
//  VKsimulator
//
//  Created by Admin on 26.12.2020.
//

import UIKit

private let reuseIdentifier = "Cell"

class FrendsCollectionViewController: UICollectionViewController {

    var frend: VKUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FrendCollectionViewCell{
            cell.imageView.image = frend?.avatarImage
            cell.labelTop.text = frend?.nicName
            if let fio = frend?.fio {
                cell.labelBottom.text = fio
            }else{
                cell.labelBottom.text = ""
            }
            return cell
        }
        
        return UICollectionViewCell()
    }


}
