//
//  CollectionViewCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 10/02/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell2: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell2"
    
    private let imageView: UIImageView = {
         let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
         fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    public func configure(with image: UIImage){
        imageView.image = image
    }
    
}
