//
//  PhotoCarousel.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 19/01/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit


protocol CollectionCellDelegate: AnyObject {
    func selectedItem(_ data: Int)
    
}

class RelatedCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "RelatedCell"
    weak var delegate: CollectionCellDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing =  10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.register(RelatedCollectionViewCell.self, forCellWithReuseIdentifier: RelatedCollectionViewCell.identifier)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor(named: "CollectionViewAlternateColor")
        collectionView.layer.cornerRadius = 10

        return collectionView
        
    }()
    
    private var images = [UIImage]()
    private var text = [String]()
    private var price = [String]()
    private var id = [Int]()
    var selectedItem = Int()

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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //print(text)
        //print(id)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelatedCollectionViewCell.identifier, for: indexPath)
                as? RelatedCollectionViewCell else {
                    fatalError()
                }
        cell.contentView.layer.cornerRadius = 5.0
        /*cell.contentView.layer.borderWidth = 1.5
        cell.contentView.layer.borderColor = UIColor(named: "PrimaryLabel")?.cgColor*/
        cell.contentView.layer.masksToBounds = true
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.cornerRadius = 5.0
                
        cell.layer.backgroundColor = UIColor(named: "CellBackgroundColorAlternate")?.cgColor
        
                cell.layer.masksToBounds = false //<-
        
        cell.configure(with: images[indexPath.row], with: text[indexPath.row], with: price[indexPath.row], with: id[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedItem = id[indexPath.row]
        //print("Selected ", text[indexPath.row])
        //print("Selected ", price[indexPath.row])
       // print(selectedItem)
        self.delegate?.selectedItem(selectedItem)
    }
    
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    public func configure(with images: [UIImage], with text: [String], with price: [String], with id: [Int]){
        
        self.images = images
        self.text = text
        self.price = price
        self.id = id
 
        collectionView.reloadData()
    }
    
    public func reload(){
        collectionView.reloadData()
    }
    
 
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((contentView.frame.size.width/2)-25), height: 150)
    }

}
