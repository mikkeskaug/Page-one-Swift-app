//
//  TypeCollectionViewCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 02/02/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit

class TypeCollectionViewCell2: UICollectionViewCell {
    static let identifier = "TypeCollectionViewCell2"
    
    
    
   
    
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
         fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    public func configure(with array: [String]){
        let number = array.count
        
        
      
        //textView.text = variables.index(forKey: number)
    }
    
    override var isSelected: Bool {
        
      
        didSet{
           
            
            
            if self.isSelected
            {
              self.transform = CGAffineTransform(scaleX: 1.03, y: 1.03)
                self.contentView.layer.borderWidth = 3.5
                contentView.layer.borderColor = UIColor.systemBlue.cgColor
              
            }
            else
            {
              self.transform = CGAffineTransform.identity
                self.contentView.layer.borderWidth = 1.5
                contentView.layer.borderColor = UIColor(named: "PrimaryLabel")?.cgColor
            }
          }
        }
    
}
