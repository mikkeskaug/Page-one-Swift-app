//
//  CategoryViewController.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 05/05/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit
import Foundation

protocol CategoryCellDelegate3: AnyObject{
    func categoryClicked(_ data: String)
}


    class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CategoryCellDelegate3 {
        
        
        
 
    var link = String()
    var name = [String]()
    var desc = [String]()
    var ids = [Int]()
    var price = [String]()
    var image = UIImage()
    var imageArray = [UIImage]()
    var descArray = [String]()
    var test2 = [Any]()
    var searchResultImage = UIImage()
    var programVar = Int()
    var selection = String()
    var headerAll = String()
    var headerAcc = String()
    
    var count = Int()
    
    var nameArray = [String]()
    var idArray = [Int]()
    var priceArray = [String]()
    var imgURLArray = [URL]()
    var productImageArray = [UIImage]()
    var dict2 = [String: [String: String]]()
    var id = Int()
    var productDescription = String ()
    var productPrice = String()
        var selectedCategory = Int()
    
  
        func categoryClicked(_ data: String) {
            
            print(data)
            programVar = Int(data)!
            
            performSegue(withIdentifier: "showRelated4", sender: self)
        }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let categoryID = ["274", "305", "282", "290", "277", "2642", "1396", "2319"]
        
        headerAll = "Alle " + selection
    
        link = "https://pageone.no/wp-json/wc/v3/products?per_page=20&orderby=price&category=" + categoryID[count]
        //print(link)
        configureSections()
        loadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.view.addSubview(self.tableView)
        self.tableView.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = false

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.isUserInteractionEnabled = true
        
  
    }//End of viewdidlayoutsubviews
    
    // MARK: - Sections
    
    enum SectionType {
        //case Featured
        case listAll (name: [String], id: [Int], price: [String], image: [UIImage])
        //case Accessories(name: [String], desc: [String], price: [String], image: [UIImage] )
        
        var title: String? {
            switch self {
            //case .Featured:
               // return ""
            case .listAll:
                return "Se alle modeller"
            //case .Accessories:
               // return "Tilbehør"
            }
        }
    }
    
    private func configureSections () {
        
        //sections.append(.Featured)
        sections.append(.listAll(name: name, id: ids, price: price, image: imageArray))
        //sections.append(.Accessories(name: name, desc: desc, price: price, image: imageArray))
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - TableView
    
    private var sections = [SectionType]()

    
    private let tableView:  UITableView = {
        let table = UITableView(frame: CGRectZero, style: .plain)
        //table.register(Featured.self, forCellReuseIdentifier: Featured.identifier)
        table.register(ListAll.self, forCellReuseIdentifier: ListAll.identifier)
        table.isScrollEnabled = false
        //table.register(Accessories.self, forCellReuseIdentifier: Accessories.identifier)
        return table
        
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
      
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
       
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(named: "PrimaryLabel")
        header.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        header.sizeToFit()
        header.tintColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
            
        /*case .Featured:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Featured.identifier,
                                                           for: indexPath) as? Featured
            else {
                fatalError()
            }
            
            cell.selectionStyle = .none
            
            return cell*/
        case .listAll(name: var name, id: var id, price: var price, image: var image):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListAll.identifier,
                                                           for: indexPath) as? ListAll
            else {
                fatalError()
            }
            
            name = self.nameArray
            price = self.priceArray
            image = self.productImageArray
            id = self.idArray
            cell.delegate = self
            //print(idArray)
            cell.configure(with: image, with: name, with: price, with: id)
            cell.selectionStyle = .none
            
            
            return cell
        /*case .Accessories(name: _, desc: _, price: _, image: _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Accessories.identifier,
                                                           for: indexPath) as? Accessories
            else {
                fatalError()
            }
            
            cell.selectionStyle = .none
            
            return cell*/
        
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        /*case .Featured:
            return 300*/
            
        case .listAll:
            var number = CGFloat()
            //print (nameArray.count)
            number = view.bounds.height-(self.navigationController?.navigationBar.frame.size.height)!-(self.tabBarController?.tabBar.frame.size.height)!
            return number
        /*case .Accessories(name: _, desc: _, price: _, image: _):
            return 500*/
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = sections[section]
        return sectionType.title
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        tableView.reloadData()
        
        
    }
       


    // MARK: Fetch data

//Fetch information about product
func loadData(){
    
    let username = "ck_0b8e854656850f88a5c009e92fce4b86f455820f"
    let password = "cs_746801f8ca71f57c5b6aa9a95cb7e042d13bed12"
    let loginString = String(format: "%@:%@", username, password)
    let loginData = loginString.data(using: String.Encoding.utf8)!
    let base64LoginString = loginData.base64EncodedString()
   
    let string = link
    

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
                
               
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                
             
                if json?.isEmpty == true {
                    DispatchQueue.main.async {
                    // create the alert
                            let alert = UIAlertController(title: "Ingen resultater funnet", message: "Prøv igjen", preferredStyle: UIAlertController.Style.alert)

                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                            // show the alert
                            self.present(alert, animated: true, completion: nil)
                    }}
                else{
                    
                
                for i in 0...json!.count-1 {
                    self.nameArray.append((json![i] as AnyObject).value(forKey: "name")! as! String)
                    self.idArray.append((json![i] as AnyObject).value(forKey: "id")! as! Int)
                    self.priceArray.append((json![i] as AnyObject).value(forKey: "price")! as! String)
                    self.descArray.append((json![i] as AnyObject).value(forKey: "description")! as! String)
                    
                    //self.imgURLArray.append((json![i] as AnyObject).value(forKey: "src")! as! URL)
                    let test = (json![i] as AnyObject).value(forKey: "images") as Any
                    
                    self.test2.append(test)
                    
                    
                    
                }
                
                
                //self.searchResultNames = (json2["name"] as! String)                    // Name
                /*self.searchResultID = (dictionary["id"] as! Int)                            //ID
                self.searchResultDesc = dictionary["description"] as! String
                self.searchResultPrice = dictionary["price"] as! String*/
                
                //print(self.nameArray)
                //print(self.idArray)
                //print(self.priceArray)
                
                for i in 0...self.test2.count-1 {
                    //print("Element nr: ", i)
                    //print(self.test2[i])
                    let string = self.test2[i] as! NSArray
                    
                    if let array = string.value(forKey: "src") as? [String] {
                        
                        let isIndexValid = array.indices.contains(0)
                        
                        if isIndexValid == true {
                            let imageURL = URL(string: array[0])
                            if let data = try? Data(contentsOf: imageURL!) {
                                    // Create Image and Update Image View
                                
                                self.searchResultImage = UIImage(data: data)!
                               
                                self.productImageArray.append(self.searchResultImage)
                               
                            }
                        }
                        else{
                            self.productImageArray.append(UIImage(named: "emptyImage")!)
                        }
                        
                        
                    }
                    
                }
                
                }
     
                
                 DispatchQueue.main.async {
                     
                     
                     
                     self.tableView.reloadData()
                     
                    
                   
                 }
            
         
                    } catch {
                        //print("error")
                    }
                
            
          
        }
 
        
        
    })
    
    
    
    
       task.resume()
    self.tableView.reloadData()
    

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
        
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
       
    
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showRelated4" {
                
               
                let navController = segue.destination as! UINavigationController
                        let detailController = navController.topViewController as? RelatedProduct
                        detailController?.programVar = programVar
                    
            }
        }

}
