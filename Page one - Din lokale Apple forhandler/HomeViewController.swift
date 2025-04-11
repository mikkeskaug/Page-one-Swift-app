//
//  HomeViewController.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 10/07/2018.
//  Copyright © 2018 MiTo Creative. All rights reserved.
//

import UIKit
import WebKit

class HomeViewController: UIViewController, WKNavigationDelegate {

  
    @IBOutlet var webView: WKWebView!
    
    private let refreshControl = UIRefreshControl()
  
    var astring = "http://www.pageone.no/butikk/"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        let url = URL(string: astring)
        var myrequest = URLRequest(url: url!)
        myrequest.httpShouldHandleCookies = false
        webView.load(myrequest)
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsBackForwardNavigationGestures = true
        
        /*refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        webView.scrollView.addSubview(refreshControl)
        webView.scrollView.bounces = true*/
        
        // Do any additional setup after loading the view.
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        // Do you your api calls in here, and then asynchronously remember to stop the
        // refreshing when you've got a result (either positive or negative)
        
        webView.reload()
        
        //refreshControl.endRefreshing()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}
