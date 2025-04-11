//
//  ServiceHostController.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 08/06/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit
import SwiftUI

//Create a UIHostingController class that hosts your SwiftUI view
class ServiceHostController: UIHostingController<ServiceView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: ServiceView())
    }
}

    
    
