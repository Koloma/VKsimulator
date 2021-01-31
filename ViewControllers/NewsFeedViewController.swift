//
//  NewsFeedViewController.swift
//  VKsimulator
//
//  Created by Admin on 19.01.2021.
//

import UIKit

class NewsFeedViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    
    let arrayNews: [String] = [
    "Начало Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. Конец",
    "Начало Small News Конец",
    "Начало ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Конец"
    ]
    
    var userNewsFeed: VKUser?{
        didSet{
            
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
        arrayNews.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //TOD доделать расчет высоты ячейки, перенести логику расчета внуьрь класса ячейки
        let heightForRowAt = 550 + arrayNews[indexPath.row].height(withConstrainedWidth: newsTableView.frame.width - 20, font: UIFont.systemFont(ofSize: 14.0))
        //print ("\(indexPath)  \(heightForRowAt)")
        return heightForRowAt
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = newsTableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.identifier, for: indexPath) as? NewsFeedTableViewCell,
           let vkUser = userNewsFeed{
            cell.configur(vkUser: vkUser, newsText: arrayNews[indexPath.row], newsImage: [UIImage(named: "pic1")!,UIImage(named: "pic2")!], imageTapFunc: imageViewTap)

            return cell
        }
        return UITableViewCell()
    }
    
    func imageViewTap(_ vkUser: VKUser){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if  let ImageGalleryVC = storyBoard.instantiateViewController(withIdentifier: "ImageGalleryCollectionViewController") as? ImageGalleryCollectionViewController{
            //Здесь передаем данные в NewsFeedViewController
            //ImageGalleryVC.vkUser = vkUser
            navigationController!.pushViewController(ImageGalleryVC, animated: true)
            
        }
    }
}


    

    
