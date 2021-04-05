//
//  NewsFeedViewController.swift
//  VKsimulator
//
//  Created by Admin on 19.01.2021.
//

import UIKit

final class NewsFeedViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
       
    private var vkNewsArray = [VKNews](){
        didSet{
            self.newsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsFeedTableViewCell.nib, forCellReuseIdentifier: NewsFeedTableViewCell.identifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadNewsData()
    }
    
    private func loadNewsData(complition: (() -> Void)? = nil){
        NetService.shared.loadUserNewsfeed(token: Session.shared.token, userId: Session.shared.userId){ [weak self] (result) in
            switch result{
            case .success(let news):
                DispatchQueue.main.async {
                    print("News count: \(news.count)")
                    self?.vkNewsArray = news
                }
            case .failure(let error):
                print(error)
            }
            complition?()
       }
    }
}



extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vkNewsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let newsText = vkNewsArray[indexPath.row].text{
            let heightForRowAt = 550 + newsText.height(withConstrainedWidth: newsTableView.frame.width - 20, font: UIFont.systemFont(ofSize: 14.0))
            return heightForRowAt
        }
        else {
            return 550
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = newsTableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.identifier, for: indexPath) as? NewsFeedTableViewCell{
            cell.configur(vkNews: vkNewsArray[indexPath.row], imageTapFunc: imageViewTap)
            return cell
        }
        return UITableViewCell()
    }
    
    func imageViewTap(_ vkNews: VKNews){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        if  let ImageGalleryVC = storyBoard.instantiateViewController(withIdentifier: "ImageGalleryCollectionViewController") as? ImageGalleryCollectionViewController{
//            navigationController!.pushViewController(ImageGalleryVC, animated: true)
//
//        }
    }
    
}


    

    
