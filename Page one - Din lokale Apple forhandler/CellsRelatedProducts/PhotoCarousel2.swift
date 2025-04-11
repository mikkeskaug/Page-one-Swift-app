//
//  PhotoCarousel.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 19/01/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit

class PhotoCarousel2: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "PhotoCarousel2"
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing =  0
        
        
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.register(PhotoCollectionViewCell2.self, forCellWithReuseIdentifier: PhotoCollectionViewCell2.identifier)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        return collectionView
        
    }()
    
    private var images = [UIImage]()

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
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell2.identifier, for: indexPath)
                as? PhotoCollectionViewCell2 else {
                    fatalError()
                }
        cell.configure(with: images[indexPath.row])
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    public func configure(with images: [UIImage]){
        
        self.images = images
        
        collectionView.reloadData()
    }
    
    public func reload(){
        collectionView.reloadData()
    }
    
 
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.size.width, height: contentView.frame.size.width)
    }

}
