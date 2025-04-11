//
//  TabBarViewController.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 24.02.2018.
//  Copyright © 2018 MiTo Creative. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    
    @IBOutlet weak var bTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        bTabBar.backgroundImage = UIImage()
        bTabBar.shadowImage = UIImage()  // removes the border

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
