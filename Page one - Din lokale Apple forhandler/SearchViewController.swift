//
//  SearchViewController.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 05/05/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit
import Foundation
import WebKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
   

    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    var searchResultNames = String()
    var searchResultImage = UIImage()
    var searchResultDesc = String()
    var searchResultPrice = String()
    var searchResultID = Int()
    var nameArray = [String]()
    var idArray = [Int]()
    var priceArray = [String]()
    var imgURLArray = [URL]()
    var descArray = [String]()
    var productImageArray = [UIImage]()
    var imageArray = [String]()
    var chosenVariable = String()
    var test2 = [Any]()

    var searching = false
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        searchBar.isUserInteractionEnabled = true
    }
    
    // MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier,
                                                       for: indexPath) as? SearchTableViewCell
        else {
            fatalError()
        }
        
        cell.imageViewer.frame = CGRect(x: self.view.frame.size.width-140, y: 15, width: 125, height: 125)
        cell.textView.text = nameArray[indexPath.row]
        cell.textView.frame = CGRect(x: 20, y: 20, width: self.view.frame.size.width/2, height: 100)
        cell.imageViewer.image = self.productImageArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        chosenVariable = "https://pageone.no/wp-json/wc/v3/products/" + String(idArray[indexPath.row])
        self.performSegue(withIdentifier: "showProductFromSearch", sender: self)
    }
 

  
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showProductFromSearch") {
            if let destVC = segue.destination as? UINavigationController,
                        let targetController = destVC.topViewController as? ProductPage {
                        targetController.link = chosenVariable
           }
        }
    }
    
    
    // MARK: - Parse
    
    func loadData() {
        
        
        
        
        let username = "ck_0b8e854656850f88a5c009e92fce4b86f455820f"
        let password = "cs_746801f8ca71f57c5b6aa9a95cb7e042d13bed12"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
       
        
        let removeSpaces = searchBar.text!.replacingOccurrences(of: " ", with: "+")
        
        let string = "https://pageone.no/wp-json/wc/v3/products?search=" + removeSpaces + "&per_page=15&orderby=price"
        //print(string)
        
        

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
                    
                    
                    //let string = String(data: data, encoding: String.Encoding.utf8)
                   
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                   
                    //var images2 = [Any]()
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
                    
                    //let images = json![i] as! Array<Any>;()

                    /*for i in 0...images.count-1 {
                    let ability = "images"
                                
                    let dict = dictionary[ability] as! NSArray
                                
                    let ability1 = dict[i] as! [String: AnyObject]
         
                    let string = ability1["src"] as? String
                    
                        let imageURL = URL(string: string!)
                    

                        // Fetch Image Data
                        if let data = try? Data(contentsOf: imageURL!) {
                                // Create Image and Update Image View
                            
                            self.searchResultImage = UIImage(data: data)!
                           
                            self.productImageArray.append(self.searchResultImage)
                           
                        }}*/
                    
                    
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
    
   
    
   
    
    // MARK: - Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            //print("Text did change")
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.priceArray.removeAll()
        self.descArray.removeAll()
        self.nameArray.removeAll()
        self.imageArray.removeAll()
        self.idArray.removeAll()
        self.test2.removeAll()
        self.productImageArray.removeAll()
        self.tableView.reloadData()
        self.view.endEditing(true)
        
        loadData()
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        self.priceArray.removeAll()
        self.productImageArray.removeAll()
        self.descArray.removeAll()
        self.nameArray.removeAll()
        self.imageArray.removeAll()
        self.idArray.removeAll()
        self.test2.removeAll()
        self.tableView.reloadData()
        tableView.reloadData()
        view.endEditing(true)
    }
    
    func JSONParseDictionary(jsonString: String) -> [String: AnyObject] {
        if let data = jsonString.data(using: String.Encoding.utf8) {
            
            do{
                if let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments )  as? [String: AnyObject] {
                    
                return dictionary
            }
                
        }
            catch {
                fatalError()
            }
        
    }
        return [String: AnyObject]()
    }

}





