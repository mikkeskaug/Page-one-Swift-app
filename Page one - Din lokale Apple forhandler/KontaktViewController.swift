//
//  KontaktViewController.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 24.02.2018.
//  Copyright © 2018 MiTo Creative. All rights reserved.
//

import UIKit
import WebKit
import StoreKit

class KontaktViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    @IBOutlet var heading: UILabel!
    @IBOutlet var textField: UITextView!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var phoneField: UITextField!
    @IBOutlet var mailField: UITextField!
    
    @IBOutlet var messageField: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Kontakt"
        
        webView = WKWebView()
        webView.navigationDelegate = self as? WKNavigationDelegate
        view = webView
        
        
        let astring = "http://www.pageone.no/kontaktapp"
     
        
        let url = URL(string: astring)!
        var myrequest = URLRequest(url: url)
        myrequest.httpShouldHandleCookies = false
        webView.load(myrequest)
        webView.allowsBackForwardNavigationGestures = true
       
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
