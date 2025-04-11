//
//  ListAllCollectionViewCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 16/05/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit

class ListAllCollectionViewCell: UICollectionViewCell {
    

    static let identifier = "ListAllCollectionViewCell"
    
    private let imageView: UIImageView = {
         let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
        
    }()
    
    private let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont.boldSystemFont(ofSize: 18)
        textLabel.textColor = UIColor(named: "PrimaryLabel")
        textLabel.text = "TEST"
        textLabel.numberOfLines = 0
        textLabel.sizeToFit()
        textLabel.backgroundColor = UIColor.clear
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont.boldSystemFont(ofSize: 12)
        priceLabel.textColor = UIColor.systemBlue
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
        
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: 165)
        textLabel.frame = CGRect(x: 0, y: imageView.frame.height, width: contentView.frame.width, height: 20)
        priceLabel.frame = CGRect(x: 0, y: imageView.frame.height+20, width: contentView.frame.width, height: 20)
        
    }
    
    public func configure(with image: UIImage, with text: String, with price: String){
        imageView.image = image
        textLabel.text = text
        priceLabel.text = ("Fra kr " + price)
     
        
    }
    
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    
    
    
   
}
