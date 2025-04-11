//
//  CategoryTableViewCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 03/03/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    static let identifier = "CategoryTableViewCell"

    private var image = [UIImage]()
    
    private var header = ["Mac", "iPhone", "iPad", "Apple Watch", "AirPods", "TV og hjem", "AirTag", "Tilbehør"]
    
    var delegate: CategoryCellDelegate?

    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing =  10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.isPagingEnabled = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = UIColor(named: "CollectionViewAlternateColor")
        
          
        return collectionView
        
    }()

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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath)
                as? CategoryCollectionViewCell else {
                    fatalError()
                }
        cell.contentView.layer.cornerRadius = 5.0
        /*cell.contentView.layer.borderWidth = 1.5
        cell.contentView.layer.borderColor = UIColor(named: "PrimaryLabel")?.cgColor*/
        cell.contentView.layer.masksToBounds = true
        cell.layer.backgroundColor = UIColor(named: "CellBackgroundColor")?.cgColor
        cell.layer.cornerRadius = 10.0
        
        image.removeAll()
        image.append(UIImage(named: "MacCategory")!)
        image.append(UIImage(named: "iPhoneCategory")!)
        image.append(UIImage(named: "iPadCategory")!)
        image.append(UIImage(named: "WatchCategory")!)
        image.append(UIImage(named: "AirpodsCategory")!)
        image.append(UIImage(named: "AppleTVCategory")!)
        image.append(UIImage(named: "AirTagCategory")!)
        image.append(UIImage(named: "TilbehorCategory")!)
        
        
        cell.imageView.image = image[indexPath.row]
        cell.titleLabel.text = header[indexPath.row]
        cell.titleLabel.textColor = UIColor(named: "PrimaryLabel")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
        print(indexPath.row)
        delegate?.categoryClicked(header[indexPath.row], selected: indexPath.row)
        
    }
    
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
 
 
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((contentView.frame.size.width)/2-25), height: ((contentView.frame.size.width)/2))
    }
    
    public func reload() {
        collectionView.reloadData()
    }

}
