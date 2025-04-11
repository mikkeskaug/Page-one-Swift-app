//
//  ProductsCollectionViewCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 03/09/2018.
//  Copyright © 2018 MiTo Creative. All rights reserved.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var typeImage: UIImageView!
    @IBOutlet var typeLabel: UILabel!
    
    func displayContent(image: UIImage, title: String){
        
        typeImage.image = image
        typeLabel.text = title
        
    }
    
}
