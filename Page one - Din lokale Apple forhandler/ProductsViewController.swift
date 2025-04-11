//
//  ProductsViewController.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 11/07/2018.
//  Copyright © 2018 MiTo Creative. All rights reserved.
//

import UIKit
import WebKit

class ProductsViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var webView: WKWebView!
    
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        webView.uiDelegate = self as? WKUIDelegate
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")  // Retrieve the state
        
        if isDarkMode == true {
            
            let myURL = URL(string:"http://pageone.no/produkterappdark/")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
        else {
            
            
            let myURL = URL(string:"http://pageone.no/produkterapp/")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            
        }
        
        
       
        
        
        
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
