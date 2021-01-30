//
//  NewsFeedViewController.swift
//  VKsimulator
//
//  Created by Admin on 19.01.2021.
//

import UIKit

class NewsFeedViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    
    var userNewsFeed: VKUser?{
        didSet{
            //Call function to find Users News
            //print(userNewsFeed!)           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsFeedTableViewCell.nib, forCellReuseIdentifier: NewsFeedTableViewCell.identifier)
       
    }

}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = newsTableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.identifier, for: indexPath) as? NewsFeedTableViewCell,
           let vkUser = userNewsFeed{
            cell.configur(vkUser: vkUser, newsText: "Big NEWS LLLL fgcf gdbbcvxbcxvbcxvbcxvbcxvb fvbv ", newsImage: [UIImage(named: "pic1")!,UIImage(named: "pic2")!])

            //cell.width =  collectionView.bounds.width
            //-NewsFeedCollectionViewCell.spacing
            //print("collectionView.bounds.width \(collectionView.bounds.width)")
            return cell
        }
        return UITableViewCell()
    }
    
    
}


    

    
