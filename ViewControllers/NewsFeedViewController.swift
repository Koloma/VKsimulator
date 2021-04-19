//
//  NewsFeedViewController.swift
//  VKsimulator
//
//  Created by Admin on 19.01.2021.
//

import UIKit

final class NewsFeedViewController: UIViewController {

    @IBOutlet private weak var newsTableView: UITableView!
       
    private var vkNewsArray = [VKNews]()
    private var nextNewsItemId = ""
    private var isLoading = false
    private let newsCount = 5
    private let nextNewsLoadBeforeEnd = 2
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .blue
        refreshControl.attributedTitle = NSAttributedString(string: "Load Data", attributes: [.font: UIFont.systemFont(ofSize: 12)])
        refreshControl.addTarget(self, action: #selector(refreshNews(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter
    }()
    
    private lazy var cacheService = CacheService(container: newsTableView)
    
    @objc private func refreshNews(_ sender: UIRefreshControl) {
        loadNewsData(from: "") {
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.newsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsFeedTableViewCell.nib,
                               forCellReuseIdentifier: NewsFeedTableViewCell.reuseCellID)
        newsTableView.refreshControl = refreshControl
        newsTableView.tableFooterView = UIView()
        newsTableView.prefetchDataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNewsData(from: "") {
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.newsTableView.reloadData()
            }
        }
    }
    
    private func loadNewsData(from: String, complition: (() -> Void)? = nil){
       
        NetService.shared.loadUserNewsfeed(newsCount: newsCount,
                                           from: from){ [weak self] (result) in
            switch result{
            case .success((let news, let nextFrom)):
                DispatchQueue.main.async {
                    print("News count: \(news.count)")
                    self?.nextNewsItemId = nextFrom
                    self?.vkNewsArray = news
                }
            case .failure(let error):
                print(error)
            }
            complition?()
       }
    }
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if vkNewsArray.isEmpty {
            tableView.showEmptyMessage("Загружаю новости...")
        } else {
            tableView.hideEmptyMessage()
        }
        return vkNewsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let newsText = vkNewsArray[indexPath.row].text{
            let heightForRowAt = 400 + newsText.height(withConstrainedWidth: newsTableView.frame.width - 20, font: UIFont.systemFont(ofSize: 14.0))
            return heightForRowAt
        }
        else {
            return 400
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = newsTableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.reuseCellID, for: indexPath) as? NewsFeedTableViewCell{
            cell.configur(indexPath: indexPath,
                          cacheService: cacheService,
                          vkNews: vkNewsArray[indexPath.row],
                          dateFormatter: dateFormatter,
                          imageTapFunc: imageViewTap)
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

extension NewsFeedViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        guard
            let maxRow = indexPaths.map({ $0.row }).max(),
            maxRow > vkNewsArray.count - nextNewsLoadBeforeEnd,
            isLoading == false
        else { return }
        
        print("Max row: \(maxRow)")
        
        isLoading = true
        NetService.shared.loadUserNewsfeed(newsCount: newsCount,
                                           from: nextNewsItemId) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result{
            case .success((let news, let nextFrom)):
                let newsCount = self.vkNewsArray.count
                
                DispatchQueue.main.async {
                    self.nextNewsItemId = nextFrom
                    self.vkNewsArray.append(contentsOf: news)
                    let indexPaths = (newsCount..<(newsCount+news.count)).map { IndexPath(row: $0, section: 0) }
                    self.newsTableView.beginUpdates()
                    self.newsTableView.insertRows(at: indexPaths, with: .automatic)
                    self.newsTableView.endUpdates()
                    self.isLoading = false
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}

    

    
