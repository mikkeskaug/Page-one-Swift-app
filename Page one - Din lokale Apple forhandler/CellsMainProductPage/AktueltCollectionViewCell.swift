//
//  AktueltCollectionViewCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 28/02/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit

class AktueltCollectionViewCell: UICollectionViewCell {
    static let identifier = "AktueltCollectionViewCell"
    
    var delegate: AktueltCellDelegate?
    
    public var url = String()
    
    public let imageView: UIImageView = {
         let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "TemplateImage")
        return imageView
        
    }()
    
    public let titleLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        textLabel.textColor = UIColor(named: "RelatedLabel")
        textLabel.text = "Airpods\n(tredje generasjon)"
        textLabel.backgroundColor = UIColor.clear
        textLabel.numberOfLines = 2
        textLabel.textAlignment = .left
        return textLabel
    }()
    
    public let descriptionLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        textLabel.textColor = UIColor(named: "RelatedLabel")
        textLabel.text = "Airpods\n(tredje generasjon)"
        textLabel.backgroundColor = UIColor.clear
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 2
        return textLabel
    }()
    
   
    
    public let view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        view.layer.cornerRadius = 10
        return view
    }()
    
    public let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kjøp", for: .normal)
        button.backgroundColor = UIColor(named: "btnColor")
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 0
        button.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
       
        return button
    }()
    
    public let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .black
        label.text = "Fra kr 23 490"
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    public var productID = Int()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(view)
        view.addSubview(button)
        view.addSubview(priceLabel)
        
    }
    
    required init?(coder: NSCoder) {
         fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 0, y: 10, width: contentView.frame.width, height: contentView.frame.height-30)
        titleLabel.frame = CGRect(x: 10, y: 0, width: contentView.frame.width, height:50)
        descriptionLabel.frame = CGRect(x: 10, y: 0, width: contentView.frame.width, height:100)
      
        
        
    }
    
    @objc func connected(sender: UIButton){
        
        print("URL: + ", url)
        delegate?.aktueltButtonClicked(url)
      
        
       
        
    }
    
    
   
   
}
