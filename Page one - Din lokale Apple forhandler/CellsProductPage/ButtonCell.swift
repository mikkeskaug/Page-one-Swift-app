//
//  ButtonCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 24/01/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit

protocol LagringCellDelegate: AnyObject {
    func getLagring(lagring: String)
    
}

class ButtonCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    static let identifier = "ButtonCell"
    var lagringsplass = [String]()
    var selectedItem = String()
    
    weak var delegate: LagringCellDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing =  10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.identifier)
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .secondarySystemBackground
       
        
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
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifier, for: indexPath)
                as? ButtonCollectionViewCell else {
                    fatalError()
                }
        cell.button.setTitle(lagringsplass[indexPath.row], for: .normal)
        cell.button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        cell.button.titleLabel?.numberOfLines = 2
        
        cell.contentView.layer.cornerRadius = 5.0
        cell.contentView.layer.borderWidth = 1.5
        cell.contentView.layer.borderColor = UIColor(named: "PrimaryLabel")?.cgColor
        cell.contentView.layer.masksToBounds = true

        
        
        cell.configure(with: lagringsplass)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return self.lagringsplass.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedItem = self.lagringsplass[indexPath.row]
        print("Lagringsplass:", selectedItem)
        self.delegate?.getLagring(lagring: selectedItem)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
    }
    
    public func configure(with array: [String]){
        
        self.lagringsplass = array
        
        collectionView.reloadData()
    }
    
    public func reload() {
        
        collectionView.reloadData()
        
    }
    
 
       
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: ((contentView.frame.size.width/2)-25), height: 75)
    }
    
    
        
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)

    }




}
