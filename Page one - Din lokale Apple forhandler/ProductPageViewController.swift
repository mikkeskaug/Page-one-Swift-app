//
//  ProductPageViewController.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 03/09/2018.
//  Copyright © 2018 MiTo Creative. All rights reserved.
//

import UIKit
import WebKit

class ProductPageViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var webView: WKWebView!
    var address: String = ""
    var headline: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(address)
        print(headline)
        self.title = headline
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var astring = appDelegate.urlString
        astring += address
        
        let url = URL(string: astring)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true

        // Do any additional setup after loading the view.
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
