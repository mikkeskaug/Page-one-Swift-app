//
//  AttributesTableViewCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 04/02/2023.
//  Copyright © 2023 MiTo Creative. All rights reserved.
//

import UIKit

class AttributesTableViewCell: UITableViewCell {
    
    static let identifier = "AttributesTableViewCell"
    
 
    public let button: UIButton = {
         let button = UIButton(type: .system)
        
         button.setTitle("128GB", for: .normal)
        button.backgroundColor = UIColor(named: "CellBackgroundColor")
         button.setTitleColor(.label, for: .normal)
         button.layer.cornerRadius = 5
         button.layer.borderWidth = 1
        button.isUserInteractionEnabled = false
        
         
    
         return button
     }()
    
    public var texLabel: UILabel = {
        
        let textLabel = UILabel()
        textLabel.text = "DETTE ER EN TEST"
        
        return textLabel
    }()
     
    
     
     required init?(coder: NSCoder) {
          fatalError()
     }
     
     override func layoutSubviews() {
         super.layoutSubviews()
  
     }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        fatalError("Error")
    }
     
     public func configure(with array: [String]){
         //let number = array.count
         //textView.text = variables.index(forKey: number)
     }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
