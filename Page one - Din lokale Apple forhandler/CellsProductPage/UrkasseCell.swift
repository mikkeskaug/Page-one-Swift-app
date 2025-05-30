//
//  UrkasseCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 04/02/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit

protocol UrkasseCellDelegate: AnyObject {
    func getUrkasse(_ data: String)
    
}

class UrkasseCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    static let identifier = "UrkasseCell"
    var urkasse = [String]()
    var selectedItem = String()
    
    weak var delegate: UrkasseCellDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing =  10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.register(UrkasseCollectionViewCell.self, forCellWithReuseIdentifier: UrkasseCollectionViewCell.identifier)
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .systemBackground
    
        
        
        return collectionView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private var variables = Dictionary <String, Any>()

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
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UrkasseCollectionViewCell.identifier, for: indexPath)
                as? UrkasseCollectionViewCell else {
                    fatalError()
                }
        cell.button.setTitle(urkasse[indexPath.row], for: .normal)
        cell.button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        cell.button.titleLabel?.numberOfLines = 2
  
        cell.contentView.layer.cornerRadius = 5.0
        cell.contentView.layer.borderWidth = 1.5
        cell.contentView.layer.borderColor = UIColor(named: "PrimaryLabel")?.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.configure(with: urkasse)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return self.urkasse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedItem = self.urkasse[indexPath.row]
        print(selectedItem)
        self.delegate?.getUrkasse(selectedItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
    }
    
    public func configure(with array: [String]){
        
        self.urkasse = array
        
        collectionView.reloadData()
    }
    
    public func reload () {
        collectionView.reloadData()
    }
    
    
 
       
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: ((contentView.frame.size.width/2)-25), height: 75)
       
   }
    
    
        
    




}

