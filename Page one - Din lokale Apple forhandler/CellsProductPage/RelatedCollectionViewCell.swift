//
//  RelatedCollectionViewCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 08/02/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit

class RelatedCollectionViewCell: UICollectionViewCell {
    static let identifier = "RelatedCollectionViewCell"
    
    private let imageView: UIImageView = {
         let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
        
    }()
    
    private let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 8)
        textLabel.textColor = UIColor(named: "RelatedLabel")
        textLabel.text = "TEST"
        textLabel.backgroundColor = UIColor.clear
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont.systemFont(ofSize: 8)
        priceLabel.textColor = UIColor(named: "RelatedLabel")
        priceLabel.text = "TEST"
        priceLabel.backgroundColor = UIColor.clear
        priceLabel.textAlignment = .center
        return priceLabel
    }()
    
    public var productID = Int()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
        contentView.addSubview(priceLabel)
        
    }
    
    required init?(coder: NSCoder) {
         fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height-30)
        textLabel.frame = CGRect(x: 0, y: imageView.frame.height-15, width: contentView.frame.width, height: 30)
        priceLabel.frame = CGRect(x: 0, y: imageView.frame.height, width: contentView.frame.width, height: 30)
        
    }
    
    public func configure(with image: UIImage, with text: String, with price: String, with id: Int){
        imageView.image = image
        textLabel.text = text
        priceLabel.text = ("Kr " + price)
        productID  = id
        
    }
   
}
