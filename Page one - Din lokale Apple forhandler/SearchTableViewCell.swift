//
//  SearchTableViewCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 09/05/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    
static let identifier = "SearchTableViewCell"
    
    public let imageViewer: UIImageView = {
        let imageViewer = UIImageView()
       imageViewer.contentMode = .scaleAspectFill
       imageViewer.clipsToBounds = true
        imageViewer.image = UIImage(named: "HeroImage")
        imageViewer.layer.cornerRadius = 10
       return imageViewer
    }()
    
   public let textView: UILabel = {
       let label = UILabel(frame: CGRect(x: 10, y: 40, width: 250, height: 20))
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "PrimaryLabel")
        label.text = "iPhone 13"
       label.numberOfLines = 4
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    
 
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    

    // MARK : INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        
    }
    
   
    
   
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
   
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        contentView.addSubview(imageViewer)
        contentView.addSubview(textView)
    
        
    }
    
   

}
