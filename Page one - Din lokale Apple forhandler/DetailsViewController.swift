//
//  DetailsViewController.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 22/04/2020.
//  Copyright © 2020 MiTo Creative. All rights reserved.
//

import Foundation
import UIKit


class DetailsViewController: UIViewController {
    
    var backgroundColor: UIColor!
    var backgroundColorName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        self.navigationItem.title = backgroundColorName
    }
}

