//
//  PricesCell.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 14/02/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit
import SwiftUI
import SafariServices

protocol TableCellDelegate: AnyObject {
    func buy(_ data: Int)
    
}



class PricesCell: UITableViewCell {
 
    
    static let identifier = "PricesCell"
    public var price = String()
    weak var delegate: TableCellDelegate?
    var pris2 = String()
    public var url = String()
    
    public let button: UIButton = {
         let button = UIButton(type: .system)
        
         button.setTitle("Åpne i nettbutikk", for: .normal)
        button.backgroundColor = .systemBlue
         button.setTitleColor(UIColor(named: "BlackLabel"), for: .normal)
         button.layer.cornerRadius = 10
         button.layer.borderWidth = 0
        
        button.addTarget(self, action: #selector(buyButton), for: .touchUpInside)
         
    
         return button
     }()
    
    public let label: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 70, width: 200, height: 50))
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "PrimaryLabel")
        label.text = "TEST"
        label.backgroundColor = UIColor.clear
        
        
        return label
    }()
    
    public var qtlabel: UILabel = {
        let qtlabel = UILabel(frame: CGRect(x: 20, y: 0, width: 100, height: 50))
        qtlabel.font = UIFont.systemFont(ofSize: 15)
        qtlabel.textColor = UIColor(named: "PrimaryLabel")
        qtlabel.text = "Antall: 1"
        qtlabel.backgroundColor = UIColor.clear
        
        
        return qtlabel
    }()
    
    public let stepper: UIStepper = {
        let stepper = UIStepper(frame: CGRect(x: 20, y: 50, width: 200, height: 200))
        stepper.contentMode = .left
        stepper.value = 1
        stepper.maximumValue = 10
        stepper.minimumValue = 1
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        
        
        
        return stepper
    }()
    
    
    
    @objc func buyButton(_ sender: UIButton!){
        print("Button pressed")
        
        let qty = Int(stepper.value)
        
        self.delegate?.buy(qty)
        print("Dette er url i cellen", url)
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }

        
        
        
    }
    
    @objc func stepperValueChanged(_ sender:UIStepper!)
      {
          qtlabel.text = "Antall: " + String(Int(stepper.value))
         
          
      }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //contentView.addSubview(label)
        //contentView.addSubview(qtlabel)
        contentView.addSubview(button)
        //contentView.addSubview(stepper)
    }
    
    // MARK : INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(button)
       // contentView.addSubview(label)
       // contentView.addSubview(qtlabel)
       // contentView.addSubview(stepper)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 20, y: 20, width: (contentView.frame.size.width)-40, height: 50)
        contentView.addSubview(label)
       // contentView.addSubview(qtlabel)
        contentView.addSubview(button)
        //contentView.addSubview(stepper)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with prices: String){
        
        label.text = "Pris fra: " + prices + " kr"
        
        
    }
    
    public func reload (string: String) {
        
        print("DID THIS WORK")
        pris2 = string
        print("PRIS2: ", pris2)
        label.text = "Pris fra: " + string + " kr"
        
    }
    
    public func updatePrice(pris: Int){
         pris2 = String(pris)
        label.text = "Pris: " + pris2
    }
    
    

}
