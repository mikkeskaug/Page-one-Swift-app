//
//  ShowProductPageViewController.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 27/11/2021.
//  Copyright © 2021 MiTo Creative. All rights reserved.
//

import UIKit
import WebKit


class ShowProductPageViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var productwebview: WKWebView!
    
    var sentUrl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(sentUrl)
        productwebview = WKWebView()
        productwebview.navigationDelegate = self
        view = productwebview
        
        let url = URL(string: sentUrl)
        
       productwebview.load(URLRequest(url: url!))
        productwebview.allowsBackForwardNavigationGestures = true
        productwebview.allowsBackForwardNavigationGestures = true
        
        
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
