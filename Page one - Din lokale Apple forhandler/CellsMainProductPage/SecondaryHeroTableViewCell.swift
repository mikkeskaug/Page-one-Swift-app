//
//  SecondaryHeroTableViewCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 25/02/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit

class SecondaryHeroTableViewCell: UITableViewCell {

    static let identifier = "SecondaryHeroTableViewCell"
    var delegate: HeroCellDelegate?
    public var text = String()
    
    public var urlDestination = String()
    
    public let imageViewer2: UIImageView = {
        let imageViewer2 = UIImageView()
       imageViewer2.contentMode = .scaleAspectFill
       imageViewer2.clipsToBounds = true
        imageViewer2.layer.cornerRadius = 10
       return imageViewer2
    }()
    
    public let textView: UILabel = {
        let label = UILabel(frame: CGRect(x: 30, y: 10, width: 300, height: 50))
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    public let describingText: UILabel = {
        let label = UILabel(frame: CGRect(x: 30, y: 40, width: 300, height: 100))
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 4
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    public let view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(named: "CellBackgroundColor")?.withAlphaComponent(0.8)
        view.layer.cornerRadius = 10
        return view
    }()
    
    public let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kjøp", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 0
        button.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
       
        return button
    }()
    
    public let pricelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor.init(named: "PrimaryLabel")
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    private var images = UIImage()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK : INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageViewer2)
        contentView.addSubview(textView)
        contentView.addSubview(view)
        contentView.addSubview(describingText)
        view.addSubview(button)
        view.addSubview(pricelabel)
        
        if text == "white"{
            textView.textColor = UIColor.init(named: "SecondaryLabel")
            describingText.textColor = UIColor.init(named: "SecondaryLabel")
        }
        else if text == "black"{
            textView.textColor = UIColor.init(named: "BlackLabel")
            describingText.textColor = UIColor.init(named: "BlackLabel")
        }
   
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func connected(sender: UIButton){
        
        delegate?.HeroBuyButtonClicked(urlDestination)
  
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))

        if text == "white"{
            textView.textColor = UIColor.init(named: "SecondaryLabel")
            describingText.textColor = UIColor.init(named: "SecondaryLabel")
        }
        else if text == "black"{
            textView.textColor = UIColor.init(named: "BlackLabel")
            describingText.textColor = UIColor.init(named: "BlackLabel")
        }
        print("Text:", text)
    }
    
    
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
  
    
    
 
       
   

}



