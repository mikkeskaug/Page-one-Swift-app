//
//  AttributesCollectionViewCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 04/02/2023.
//  Copyright © 2023 MiTo Creative. All rights reserved.
//

import UIKit

class AttributesCollectionViewCell: UICollectionViewCell {
 
    static let identifier = "AttributesCollectionViewCell"
    
    public let button: UIButton = {
         let button = UIButton(type: .system)
        
         button.setTitle("Black", for: .normal)
        button.backgroundColor = UIColor(named: "CellBackgroundColor")
         button.setTitleColor(.label, for: .normal)
         button.layer.cornerRadius = 5
         button.layer.borderWidth = 1
        button.isUserInteractionEnabled = false

         
    
         return button
     }()
     
     override init(frame: CGRect) {
         super.init(frame: frame)
        
         button.frame = contentView.frame
         contentView.addSubview(button)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}
