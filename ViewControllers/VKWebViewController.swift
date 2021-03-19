//
//  VKWebViewController.swift
//  VKsimulator
//
//  Created by Admin on 11.02.2021.
//

import UIKit
import WebKit
import FirebaseAuth

class VKWebViewController: UIViewController {

    static let segueIdentifier = "to_first_screen"
    private var listener: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var webView: WKWebView!{
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        listener = Auth.auth().addStateDidChangeListener({ [weak self] (auth, user) in
            guard user != nil else { return }
            self?.performSegue(withIdentifier: VKWebViewController.segueIdentifier, sender: self)
        })
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
        
        let params = fragment
            .components(separatedBy: "&")
            .map{$0.components(separatedBy: "=")}
            .reduce([String: String]()){ result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }

        guard let token = params["access_token"]
              ,let userId = params["user_id"]
        else {
            decisionHandler(.allow)
            return
        }
        
        Session.shared.token = token
        Session.shared.userId = Int.init(userId)!
        let userEmail = "any@user.com"
        let password = "123456"
        Auth.auth().signIn(withEmail: userEmail, password: password) { (result, error) in
            if let error = error{
                print(error)
                Auth.auth().createUser(withEmail: userEmail, password: password) { (result, error) in
                    if let error = error{
                        print(error)
                    }else{
                        print("Create new User: \(userEmail)")
//                        self?.performSegue(withIdentifier: VKWebViewController.segueIdentifier, sender: self)
                    }
                }
            }else{
                print("Auth success")
//                self?.performSegue(withIdentifier: VKWebViewController.segueIdentifier, sender: self)
            }
        }
        
        decisionHandler(.cancel)
        
    }
}
