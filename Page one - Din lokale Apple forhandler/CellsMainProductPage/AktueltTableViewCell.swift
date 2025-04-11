//
//  AktueltTableViewCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 28/02/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit
import Foundation

class AktueltTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AktueltCellDelegate  {
    

    static let identifier = "AktueltTableViewCell"
    weak var delegate: AktueltTableDelegate?
    
    private var aktueltDict = Dictionary<Int, [String]>()
    
    var itemSize = CGSize()
    private var images = [UIImage]()
    private var count = 0
    var url = String()
    
    func aktueltButtonClicked(_ data: String) {
        url = data
        aktuelt()
    }
    
    func aktuelt() {
        self.delegate?.aktueltButtonClicked2(url)
    }
    
    public let collectionView: UICollectionView = {
        let layout = CarouselCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing =  10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.register(AktueltCollectionViewCell.self, forCellWithReuseIdentifier: AktueltCollectionViewCell.identifier)
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = UIColor(named: "CollectionViewColor")
        collectionView.layer.cornerRadius = 10
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
       
        
        return collectionView
        
    }()
    

    var selectedItem = Int()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
      
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let pageWidth: Float = Float(contentView.frame.width - 105) //480 + 50
               // width + space
               let currentOffset: Float = Float(scrollView.contentOffset.x)
               let targetOffset: Float = Float(targetContentOffset.pointee.x)
               var newTargetOffset: Float = 0
               if targetOffset > currentOffset {
                   newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
               }
               else {
                   newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
               }
               if newTargetOffset < 0 {
                   newTargetOffset = 0
               }
               else if (newTargetOffset > Float(scrollView.contentSize.width)){
                   newTargetOffset = Float(Float(scrollView.contentSize.width))
               }

               targetContentOffset.pointee.x = CGFloat(currentOffset)
               scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: scrollView.contentOffset.y), animated: true)

      
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
    
    public func configure(with dict: Dictionary<Int, [String]>, images: [UIImage]){
        
        self.aktueltDict = dict
        self.images = images
        collectionView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        collectionView.frame = contentView.bounds
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AktueltCollectionViewCell.identifier, for: indexPath)
                as? AktueltCollectionViewCell else {
                    fatalError()
                }
      
        cell.delegate = self
        cell.contentView.layer.cornerRadius = 5.0
        /*cell.contentView.layer.borderWidth = 1.5
        cell.contentView.layer.borderColor = UIColor(named: "PrimaryLabel")?.cgColor*/
        cell.contentView.layer.masksToBounds = true
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.cornerRadius = 10.0
                cell.layer.borderWidth = 0.0
        cell.layer.shadowColor = UIColor.init(named: "ShadowColor")?.cgColor
                cell.layer.shadowOffset = CGSize(width: 0, height: 5)
                cell.layer.shadowRadius = 5.0
                
                cell.layer.shadowOpacity = 5
                cell.layer.masksToBounds = false //<-
        
      
       
        
        if let temp = aktueltDict[indexPath.row+1] {
             cell.priceLabel.text = temp[3]
            cell.titleLabel.text = temp[0]
            cell.descriptionLabel.text = temp[1]
            cell.url = temp[2]

        }
        cell.imageView.image = images[indexPath.row]
    
        
        cell.view.frame = CGRect(x: 0, y: cell.contentView.frame.height-60, width: cell.contentView.frame.width, height: 60)
        cell.button.frame = CGRect(x: Int(cell.contentView.frame.width) - 80, y: Int(cell.view.frame.height)/2-15, width: 70, height: 30)
        cell.priceLabel.frame = CGRect(x: 10, y: Int(cell.view.frame.height)/2-10, width: 100, height: 30)
       
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return aktueltDict.count
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
    
 
 
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        itemSize = CGSize(width: ((contentView.frame.size.width)-100), height: contentView.frame.size.height-50)
        return itemSize
    }
    
    public func reload () {
        collectionView.reloadData()
    }
    
  
    
    
    
   

}
