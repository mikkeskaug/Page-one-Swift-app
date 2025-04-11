//
//  CategoryCollectionViewCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 03/03/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    
    public let imageView: UIImageView = {
         let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage(named: "TemplateImage")
        return imageView
        
    }()
    
    public let titleLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        textLabel.textColor = UIColor(named: "RelatedLabel")
        textLabel.text = "Mac"
        textLabel.backgroundColor = UIColor.clear
        textLabel.numberOfLines = 2
        textLabel.textAlignment = .left
        return textLabel
    }()
    



    
    public var productID = Int()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    
    }
    

    
    required init?(coder: NSCoder) {
         fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 5, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        titleLabel.frame = CGRect(x: 10, y: 10, width: contentView.frame.width, height:20)
        
        
    }
    
   
   
}
