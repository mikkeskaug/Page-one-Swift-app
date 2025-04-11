//
//  MyCollectionViewCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 25/11/2021.
//  Copyright © 2021 MiTo Creative. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myLabel: UILabel!
    
    
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var productImage: UIImageView!
    
    override func layoutSubviews() {
            // cell rounded section
            self.layer.cornerRadius = 15.0
            self.layer.borderWidth = 5.0
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.masksToBounds = true
            
            // cell shadow section
            self.contentView.layer.cornerRadius = 15.0
            self.contentView.layer.borderWidth = 5.0
            self.contentView.layer.borderColor = UIColor.clear.cgColor
            self.contentView.layer.masksToBounds = true
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
            self.layer.shadowRadius = 3.0
            self.layer.shadowOpacity = 0.3
            self.layer.cornerRadius = 15.0
            self.layer.masksToBounds = false
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        if self.traitCollection.userInterfaceStyle == .dark {
            self.myLabel.textColor = UIColor.black
            self.priceLabel.textColor = UIColor.black
        }
        }
    
}



