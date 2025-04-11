//
//  ProductPage.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 19/01/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit
import Foundation
import WebKit



class RelatedProduct: UIViewController, UITableViewDelegate, UITableViewDataSource, TableCellDelegate, ColorCellDelegate, FargeCellDelegate, LagringCellDelegate, MinneCellDelegate, UrkasseCellDelegate, TilkoblingCellDelegate, fetchSelectedType{
    
    func sendSelectedType(_ data: String) {
        print("selectedType")
        selectedType = data
    }
    

    var images2 = [Array<Any>]()
    var dict = [String: String]()
    var nameArray = [String]()
    var idArray = [Int]()
    var priceArray = [String]()
    var imgURLArray = [URL]()
    var productImageArray = [UIImage]()
    var dict2 = [String: [String: String]]()
    var names = String()
    var image = UIImage()
    var productDescription = String ()
    var productPrice = String()
    var count = Int()
    var variables = Dictionary<String, Any>()
    var lagringsplass = [String]()
    var finish = [String]()
    var type = [String]()
    var farge = [String]()
    var minne = [String]()
    var tilkobling = [String]()
    var urkasse = [String]()
    var id = Int()
    var programVar = Int()
    var qty = Int()
    var selectedColor = String()
   var selectedType = String()
    var selectedMinne = String()
    var selectedLagring = String()
    var selectedFarge = String()
    var selectedUrkasse = String()
    var selectedTilkobling = String()
    var chosenVariables = [String]()
    var link = String()
    var attributes = Dictionary<String, Array<String>>()

    func getColor(_ data: String) {
        selectedColor = data
    }

    
    func getLagring(lagring: String){
        selectedLagring = lagring
        
    }
    
    func getMinne(_ data: String) {
        selectedMinne = data
    }
    
    func getFarge(_ data: String) {
        selectedFarge = data
    }
    
    func getUrkasse(_ data: String) {
        selectedUrkasse = data
    }
    
    func getTilkobling(_ data: String) {
        selectedTilkobling = data
    }
    
    func buy(_ data: Int){
        
        print("Button pressed")
        qty = data
        print("quantity: ", qty)
        /*
        if finish.isEmpty {
          
        }
        else {
            print(selectedColor)
            if selectedColor.isEmpty {
                // create the alert
                        let alert = UIAlertController(title: "Velg finish", message: "Du må velge finish først.", preferredStyle: .alert)
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
            }
            else {
                chosenVariables.append(selectedColor)
            }
        }
        
        if lagringsplass.isEmpty {
            
        }
        else {
            print(selectedLagring)
            if selectedLagring.isEmpty {
                // create the alert
                        let alert = UIAlertController(title: "Velg Lagring", message: "Du må velge lagring først.", preferredStyle: .alert)
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
            }
            else {
                chosenVariables.append(selectedLagring)
            }
            
        }
        
        if type.isEmpty {
            print("Type is empty")
        }
        else {
            if selectedType.isEmpty {
                // create the alert
                        let alert = UIAlertController(title: "Velg Type", message: "Du må velge type først.", preferredStyle: .alert)
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
            }
            else {
                chosenVariables.append(selectedType)
            }
            
        }
        
        if minne.isEmpty {
            
        }
        else {
            print(selectedMinne)
            if selectedMinne.isEmpty {
                // create the alert
                        let alert = UIAlertController(title: "Velg Minne", message: "Du må velge minne først.", preferredStyle: .alert)
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
            }
            else {
                chosenVariables.append(selectedMinne)
            }
            
        }
        
        if farge.isEmpty {
            
        }
        else {
            print(selectedFarge)
            if selectedFarge.isEmpty {
                // create the alert
                        let alert = UIAlertController(title: "Velg Farge", message: "Du må velge farge først.", preferredStyle: .alert)
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
            }
            else {
                chosenVariables.append(selectedFarge)
            }
            
        }
        
        if tilkobling.isEmpty {
            
        }
        else {
            print(selectedTilkobling)
            if selectedTilkobling.isEmpty {
                // create the alert
                        let alert = UIAlertController(title: "Velg Tilkobling", message: "Du må velge tilkobling først.", preferredStyle: .alert)
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
            }
            else {
                chosenVariables.append(selectedTilkobling)
            }
            
        }
        
        if urkasse.isEmpty {
            
        }
        else {
            print(selectedUrkasse)
            if selectedUrkasse.isEmpty {
                // create the alert
                        let alert = UIAlertController(title: "Velg Urkasse", message: "Du må velge urkasse først.", preferredStyle: .alert)
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
            }
            else {
                chosenVariables.append(selectedUrkasse)
            }
            
        }
         */
        
       print(chosenVariables)
        chosenVariables.removeAll()
    }
    
    
    enum SectionType {
        case productPhotos(images: [UIImage])
        case storage ([String])
        case color ([String])
        case productInfo(viewModels : [TextViewCellModel])
        case attributes(Dictionary<String, [String]>)
        case buy(prices: String)
        case type ([String])
        case farge ([String])
        case minne ([String])
        case tilkobling ([String])
        case urkasse ([String])
      
 
       
        var title: String? {
            switch self {
            case .productPhotos:
                return "Produktgalleri"
            case.productInfo:
                return "Beskrivelse:"
           
            case .storage(_):
                return "Velg lagringsplass:"
                
            case .color(_):
                return "Velg finish:"
            
            case .type:
                return "Velg type"
                
            case .farge:
                return "Velg farge"
                
            case .minne:
                return "Velg minne"
            
            case .tilkobling:
                return "Velg tilkobling"
                
            case .urkasse:
                return "Velg størrelse på urkassen"
            case .buy(_):
                return "Kjøp"
            case .attributes(variants: _):
                return "Valgmuligheter:"
            
        
            }
        }
        
    }
    
    typealias JSONDictionary = [String:Any]
    
    
    struct Products: Codable {
      let id: Int
      let name: String
      let price: String
      let images: [Images]
      let description: String
    }

    struct Images: Codable {
        let name: String
        let id: Int
        let src: String
        
    }
    

    //Declare tableview
    private let tableView:  UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(PhotoCarousel2.self, forCellReuseIdentifier: PhotoCarousel2.identifier)
        table.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.identifier)
        table.register(AttributesCell.self, forCellReuseIdentifier: AttributesCell.identifier)
        table.register(UrkasseCell.self, forCellReuseIdentifier: UrkasseCell.identifier)
        table.register(TilkoblingCell.self, forCellReuseIdentifier: TilkoblingCell.identifier)
        table.register(ColorCell.self, forCellReuseIdentifier: ColorCell.identifier)
        table.register(TypeCell2.self, forCellReuseIdentifier: TypeCell2.identifier)
        table.register(MinneCell.self, forCellReuseIdentifier: MinneCell.identifier)
        table.register(FargeCell.self, forCellReuseIdentifier: FargeCell.identifier)
        table.register(PricesCell.self, forCellReuseIdentifier: PricesCell.identifier)


        table.isUserInteractionEnabled = true
        return table
        
    }()
    
    private var sections = [SectionType]()
    
    override func viewDidAppear(_ animated: Bool) {
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        //Add tableview as subview, datasource, delegate
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.isUserInteractionEnabled = true
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .always
            
        }
        else if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
            
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
            navigationController?.navigationBar.titleTextAttributes = attributes

            
        }
        else if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.mac {
            
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .always
            
        }
       
        
       
    }//End of func viewdidload
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.tableView.reloadData()
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ColorCell.identifier) as? ColorCell
                
        else {
            fatalError()
        }
        cell.reload()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.identifier) as? ButtonCell
                
        else {
            fatalError()
        }
        cell.reload()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TypeCell2.identifier) as? TypeCell2
                
        else {
            fatalError()
        }
        cell.reload()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MinneCell.identifier) as? MinneCell
                
        else {
            fatalError()
        }
        cell.reload()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FargeCell.identifier) as? FargeCell
                
        else {
            fatalError()
        }
        cell.reload()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UrkasseCell.identifier) as? UrkasseCell
                
        else {
            fatalError()
        }
        cell.reload()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TilkoblingCell.identifier) as? TilkoblingCell
                
        else {
            fatalError()
        }
        cell.reload()
        
        
        
    }
    
    private func configureSections () {
      
        //print(self.productImageArray)
        sections.append(.productPhotos(images: [
            self.productImageArray[0]
        ].compactMap({$0})
            ))
        /*
        if self.farge.isEmpty {
            
        }
        else {
            sections.append(.farge(self.farge))
        }
        if self.finish.isEmpty {
            
        }
        else {
            sections.append(.color(self.finish))
        }
        if self.minne.isEmpty {
            
        }
        else {
            sections.append(.minne(self.minne))
        }
        if self.lagringsplass.isEmpty {
            //Do not create section if empty
        }
        else {
        sections.append(.storage(self.lagringsplass))
        }
        
        
        if self.type.isEmpty {
            
        }
        else {
            sections.append(.type(self.type))
        }
        
        
        
        if self.tilkobling.isEmpty {
            
        }
        else {
            sections.append(.tilkobling(self.tilkobling))
        }
        if self.urkasse.isEmpty {
            
        }
        else {
            sections.append(.urkasse(self.urkasse))
        }*/
        if self.productPrice.isEmpty {
            
        }
        else {
            sections.append(.buy(prices: self.productPrice))
        }
       
        
        
        
        sections.append(.productInfo (viewModels: [
            TextViewCellModel(text: productDescription,
                              font: .systemFont(ofSize: 14)),
            TextViewCellModel(text: productPrice,
                              font: .systemFont(ofSize: 25 ))
            ]))
            
        sections.append(.attributes(self.attributes))
   
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.isUserInteractionEnabled = true
        
        
    }//End of viewdidlayoutsubviews
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        let sectionType = sections[indexPath.section]
         
        switch sectionType {
            
        case .productPhotos(var images):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCarousel2.identifier,
                                                           for: indexPath) as? PhotoCarousel2
            else {
                fatalError()
            }
            images = self.productImageArray
            
            cell.configure(with: images)
            return cell
            
        case .color(let array):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ColorCell.identifier, for: indexPath) as? ColorCell
            else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: array)
            return cell
            
        case .storage(let array):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell
            else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: array)
            return cell
            
        
            
        case .productInfo (let viewModels):
            let viewModel = viewModels[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                           for: indexPath)
            
            cell.configure(with: viewModel)
            return cell
            
        
        case .type(with: let array):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TypeCell2.identifier, for: indexPath) as? TypeCell2
            else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: array)
            return cell
        case .farge(with: let array):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FargeCell.identifier, for: indexPath) as? FargeCell
            else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: array)
            return cell
            
        case .minne(with: let array):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MinneCell.identifier, for: indexPath) as? MinneCell
            else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: array)
            return cell
            
        case .tilkobling(with: let array):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TilkoblingCell.identifier, for: indexPath) as? TilkoblingCell
            else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: array)
            return cell
            
        case .urkasse(with: let array):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UrkasseCell.identifier, for: indexPath) as? UrkasseCell
            else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: array)
            return cell
            
        case .buy(let prices):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PricesCell.identifier, for: indexPath) as? PricesCell
            else {
                fatalError()
                
            }
            
            cell.configure(with: prices)
            cell.url = self.link
            cell.delegate = self
            cell.backgroundColor = UIColor(named: "CellBackgroundColor")
            cell.layer.cornerRadius = 5
            cell.selectionStyle = .none
            return cell
            
            
        case .attributes(let variants):
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AttributesCell.identifier, for: indexPath) as? AttributesCell
            else {
                fatalError()
                
            }
            
            cell.configure(with: variants)
            cell.selectionStyle = .none
            return cell
        }
    
    
        
    }//end of func cellforrow
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }//End of func numbers of rows
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = sections[indexPath.section]
        switch sectionType {
            
        case.productPhotos:
            return view.frame.size.width
        case .storage:
            var number = CGFloat()
            
            if self.lagringsplass.count <= 2 {
                number = 120
            }
            else if self.lagringsplass.count <= 4 {
                number = 200
            }
            else if self.lagringsplass.count <= 6 {
                number = 300
            }
            else {
                return 200
            }
            
            return number
        case .color:
            var number = CGFloat()
            
            if self.finish.count <= 2 {
                number = 120
            }
            else if self.finish.count <= 4 {
                number = 200
            }
            else if self.finish.count <= 6 {
                number = 300
            }
            else {
                return 200
            }
            
            return number
        case .productInfo:
            return UITableView.automaticDimension

 
            
        case .type(_):
            
            var number = CGFloat()
            
            if self.type.count <= 2 {
                number = 120
            }
            else if self.type.count <= 4 {
                number = 200
            }
            else if self.type.count <= 6 {
                number = 300
            }
            else if self.type.count <= 8 {
                number = 400
            }
            else if self.type.count <= 10 {
                number = 450
            }
            else if self.type.count <= 12 {
                number = 550
            }
            else {
                return 200
            }
            
            return number
            
        case .farge(_):
            var number = CGFloat()
            
            if self.farge.count <= 2 {
                number = 120
            }
            else if self.farge.count <= 4 {
                number = 200
            }
            else if self.farge.count <= 6 {
                number = 300
            }
            else {
                return 200
            }
            
            return number
        case .minne(_):
            var number = CGFloat()
            
            if self.minne.count <= 2 {
                number = 120
            }
            else if self.minne.count <= 4 {
                number = 200
            }
            else if self.minne.count <= 6 {
                number = 300
            }
            else {
                return 200
            }
            
            return number
        case .tilkobling(_):
            var number = CGFloat()
            
            if self.tilkobling.count <= 2 {
                number = 120
            }
            else if self.tilkobling.count <= 4 {
                number = 200
            }
            else if self.tilkobling.count <= 6 {
                number = 300
            }
            else {
                return 200
            }
            
            return number
            case .urkasse(_):
            var number = CGFloat()
            
            if self.urkasse.count <= 2 {
                number = 120
            }
            else if self.urkasse.count <= 4 {
                number = 200
            }
            else if self.urkasse.count <= 6 {
                number = 300
            }
            else {
                return 200
            }
            
            return number
        case .buy(prices: _):
            return 100
        
        case .attributes(_):
            return 300
        
        
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = sections[section]
        return sectionType.title
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
     
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.secondaryLabel
    }
    
    
    
    //Fetch information about product
    func loadData(){
        
        let username = "ck_0b8e854656850f88a5c009e92fce4b86f455820f"
        let password = "cs_746801f8ca71f57c5b6aa9a95cb7e042d13bed12"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let string = "https://pageone.no/wp-json/wc/v3/products/" + String(programVar)
        
        

        let request = NSMutableURLRequest(url: NSURL(string: string)! as URL)
        let session = URLSession.shared
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         request.addValue("application/json", forHTTPHeaderField: "Accept")
           
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if let data = data {
              
                do {
                    
                    
                    let string = String(data: data, encoding: String.Encoding.utf8)
                    let dictionary = self.JSONParseDictionary(jsonString: string!)
                    
                    self.names = (dictionary["name"] as? String)!                    // Name
                   // let id = dictionary["id"] as? Int                            //ID
                    self.productDescription = dictionary["description"] as! String
                    self.productPrice = dictionary["price"] as! String
                    self.link = dictionary["permalink"] as! String
                    
              
                    let images = dictionary["images"] as! Array<Any>;()
                    let attributes = dictionary["attributes"] as! Array<Any>;()
                    
                    
                    
                    self.count = attributes.count
                    
                
                  
                    if self.count != 0 {
                    for i in 0...attributes.count-1 {
                       
                        let ability = "attributes"
                        let dict = dictionary[ability] as! NSArray
                        let ability1 = dict[i] as! [String: AnyObject]
                        let string = ability1["name"] as? String
                        let string2 = ability1["options"] as? NSArray
                        
                        var array = [String]()
                        
                  
                        let objCArray = NSMutableArray(array: string2!)

                        if let swiftArray = objCArray as NSArray as? [String] {

                            // Use swiftArray here
                            array = swiftArray
                        }
                        
                        self.attributes[string!] = array
                        print(self.attributes)
                     
                        if string == "Lagringsplass"{
                            
                            let objCArray = NSMutableArray(array: string2!)

                            if let swiftArray = objCArray as NSArray as? [String] {

                                // Use swiftArray here
                                self.lagringsplass = swiftArray
                            }
                            //print(self.lagringsplass)
                        }
                        else if string == "Velg finish" {
                            
                            let objCArray = NSMutableArray(array: string2!)

                            if let swiftArray = objCArray as NSArray as? [String] {

                                // Use swiftArray here
                                self.finish = swiftArray
                            }
                            //print(self.finish)
                        }
                        else if string == "Farge" {
                            
                            let objCArray = NSMutableArray(array: string2!)

                            if let swiftArray = objCArray as NSArray as? [String] {

                                // Use swiftArray here
                                self.farge = swiftArray
                            }
                            //print("Farge", self.farge)
                           
                        }
                        else if string == "Type" {
                            
                            //print(string2 as Any)
                            if string2 == nil {
                                
                            }
                            else{
                            let objCArray = NSMutableArray(array: string2!)

                            if let swiftArray = objCArray as NSArray as? [String] {

                                // Use swiftArray here
                                self.type = swiftArray
                            }
                            }
                            //print(self.type)
                        }
                        else if string == "Minne" {
                            
                            let objCArray = NSMutableArray(array: string2!)

                            if let swiftArray = objCArray as NSArray as? [String] {

                                // Use swiftArray here
                                self.minne = swiftArray
                            }
                            //print(self.minne)
                        }
                        else if string == "Tilkobling" {
                            
                            let objCArray = NSMutableArray(array: string2!)

                            if let swiftArray = objCArray as NSArray as? [String] {

                                // Use swiftArray here
                                self.tilkobling = swiftArray
                            }
                           // print(self.tilkobling)
                        }
                        else if string == "Størrelse på urkassen" {
                            
                            let objCArray = NSMutableArray(array: string2!)

                            if let swiftArray = objCArray as NSArray as? [String] {

                                // Use swiftArray here
                                self.urkasse = swiftArray
                            }
                           // print(self.urkasse)
                        }
                    
                        self.variables[string!] = string2
                        
                        
                    }
                    }
                   
                    for i in 0...images.count-1 {
                    let ability = "images"
                                
                    let dict = dictionary[ability] as! NSArray
                                
                    let ability1 = dict[i] as! [String: AnyObject]
         
                    let string = ability1["src"] as? String
                    
                        let imageURL = URL(string: string!)
                    

                        // Fetch Image Data
                        if let data = try? Data(contentsOf: imageURL!) {
                                // Create Image and Update Image View
                            //print(data)
                            self.image = UIImage(data: data)!
                           
                            self.productImageArray.append(self.image)
                            //print(self.productImageArray)
                        }}
                    
                    
                     DispatchQueue.main.async {
                         
                         
                         //print("ConfiguringSections")
                         self.configureSections()
                         self.tableView.reloadData()
                         
                         //self.title = self.names
                         let titleLabel = UILabel()
                         if let index = self.names.range(of: "tommer")?.upperBound {
                             let substring = self.names[..<index]                 // "ora"
                             // or  let substring = word.prefix(upTo: index) // "ora"
                             // (see picture below) Using the prefix(upTo:) method is equivalent to using a partial half-open range as the collection’s subscript.
                             // The subscript notation is preferred over prefix(upTo:).

                             let string = String(substring)
                             
                             titleLabel.text = string
                         }
                         else {
                             titleLabel.text = self.names
                         }
                         
                         //titleLabel.text = self.names
                         titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
                         titleLabel.adjustsFontSizeToFitWidth = true
                         titleLabel.numberOfLines = 2
                         
                         self.navigationItem.titleView = titleLabel
                        
                       
                     }
                
             
                        }
                    
                
                
            }
            
            
        })
        
        
    
        
           task.resume()
       
    
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func checkForUrls(text: String) -> [URL] {
        let types: NSTextCheckingResult.CheckingType = .link

        do {
            let detector = try NSDataDetector(types: types.rawValue)

            let matches = detector.matches(in: text, options: .reportCompletion, range: NSMakeRange(0, text.count))
        
            return matches.compactMap({$0.url})
        } catch let error {
            debugPrint(error.localizedDescription)
        }

        return []
    }
    
    
   
    func JSONParseDictionary(jsonString: String) -> [String: AnyObject] {
        if let data = jsonString.data(using: String.Encoding.utf8) {
            do{
                if let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))  as? [String: AnyObject] {
                return dictionary
            }
                
        }
            catch {
                fatalError()
            }
        
    }
        return [String: AnyObject]()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        tableView.reloadData()
    }
    
    
    
}//End of class product page



    




