//
//  NewsFeed2ViewController.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 21.03.2021.
//

import UIKit

final class NewsFeed2ViewController: UIViewController {


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadNewsData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func loadNewsData(complition: (() -> Void)? = nil){
        NetService.shared.loadUserNewsfeed(token: Session.shared.token, userId: Session.shared.userId){ [weak self] (result) in
            switch result{
            case .success(let news):
                DispatchQueue.main.async {
                    print("News count: \(news.count)")
                    _ = news.map{ print($0.text as Any)}
                }
            case .failure(let error):
                print(error)
            }
            complition?()
       }
    }

}
