//
//  VKWebViewController.swift
//  VKsimulator
//
//  Created by Admin on 11.02.2021.
//

import UIKit
import WebKit

class VKWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!{
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goToVKautorize()
    }
    
    
    func goToVKautorize(){
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7757926"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: K.ApiVK.v)
        ]
            
        if let url = urlComponents.url{
            let request = URLRequest(url: url)
            webView.load(request)
        }else{
            print ("Wron URL conversion")
        }
        
        
    }
}

extension VKWebViewController: WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else{
            decisionHandler(.allow)
            return
        }
        //print("fragment \(fragment)")
        
        let params = fragment
            .components(separatedBy: "&")
            .map{$0.components(separatedBy: "=")}
            .reduce([String: String]()){ result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                //print("\(key)  \(value)")
                dict[key] = value
                return dict
            }
        //print("params: \(params)")
        guard let token = params["access_token"]
              ,let userId = params["user_id"]
        else {
            decisionHandler(.allow)
            return
        }
        
        Session.shared.token = token
        Session.shared.userId = Int.init(userId)!
        performSegue(withIdentifier: "to_first_screen", sender: self)
        //VKNetService.shared.loadFriends(token: token)
//        VKNetService.shared.loadFriends(token: token){ friends in
//
//        }
        decisionHandler(.cancel)
        

        //VKNetService.shared.loadUserImages(token: token, userId: Session.shared.userId )
        //VKNetService.shared.groupsSearch(token: token, textQuery: "GeekBrains")
        
        //decisionHandler(.cancel)
        
    }
}
