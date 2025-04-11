//
//  ListAll.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 13/05/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit

class ListAll: UITableViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    

    static let identifier = "ListAll"
    var delegate: CategoryCellDelegate3?
    private var header = ["Mac", "iPhone", "iPad", "Apple Watch", "AirPods", "Apple TV", "AirTag", "Tilbehør"]
    var names = [String]()
    var price = [String]()
    var id = [Int]()
    var images = [UIImage]()
    var chosenVariable = String()
    var descriptionArray = [String]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing =  10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.register(ListAllCollectionViewCell.self, forCellWithReuseIdentifier: ListAllCollectionViewCell.identifier)
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = UIColor(named: "CellListAllColor")
        collectionView.layer.cornerRadius = 10
        collectionView.isUserInteractionEnabled = true
        //collectionView.isScrollEnabled = false

        return collectionView
        
    }()
    
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
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with images: [UIImage], with text: [String], with price: [String], with id: [Int]){
        
        self.images = images
        self.names = text
        self.price = price
        self.id = id
      
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListAllCollectionViewCell.identifier, for: indexPath)
                as? ListAllCollectionViewCell else {
                    fatalError()
                }
        cell.contentView.layer.cornerRadius = 5.0
        /*cell.contentView.layer.borderWidth = 1.5
        cell.contentView.layer.borderColor = UIColor(named: "PrimaryLabel")?.cgColor*/
        cell.contentView.layer.masksToBounds = true
        cell.layer.backgroundColor = UIColor(named: "CellListAllColor")?.cgColor
        cell.layer.cornerRadius = 5.0
                
        cell.layer.backgroundColor = UIColor(named: "CellListAllColor")?.cgColor
        
                cell.layer.masksToBounds = false //<-
        
        cell.configure(with: images[indexPath.row], with: names[indexPath.row], with: price[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((contentView.frame.size.width)-25), height: 225)
    }
    
    public func reload(){
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
     
        chosenVariable = String(id[indexPath.row])
     
        delegate?.categoryClicked(chosenVariable)
    }
    
    func lets() {
        
    }
    
    

}
