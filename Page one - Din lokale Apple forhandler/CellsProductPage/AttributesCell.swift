//
//  AttributesCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 04/02/2023.
//  Copyright © 2023 MiTo Creative. All rights reserved.
//

import UIKit

class AttributesCell: UITableViewCell {
    
    static let identifier = "AttributesCell"
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing =  10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.register(AttributesCollectionViewCell.self, forCellWithReuseIdentifier: AttributesCollectionViewCell.identifier)
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .systemBackground
    
        
        
        return collectionView
    }()
    
    public let textView: UITextView = {
        
        let textView = UITextView()
        
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textColor = UIColor(named: "PrimaryLabel")
        textView.text = "Dette er en test"
        textView.isEditable = false
        textView.isSelectable = false
        textView.backgroundColor = UIColor.clear
        
        return textView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK : INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(textView)
        // contentView.addSubview(label)
        // contentView.addSubview(qtlabel)
        // contentView.addSubview(stepper)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textView.frame = CGRect(x: 20, y: 10, width: (contentView.frame.size.width)-40, height: contentView.frame.size.height)
        //contentView.addSubview(label)
       // contentView.addSubview(qtlabel)
        contentView.addSubview(textView)
        //contentView.addSubview(stepper)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with dictionary: Dictionary<String, [String]>){
        
       
        var fullDict = ""

        for (x, y) in dictionary {
            fullDict += "\(x):\n \(y)\n\n"
        }


        textView.text = fullDict
        
    }

}
