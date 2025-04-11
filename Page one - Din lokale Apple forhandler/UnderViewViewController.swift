//
//  UnderViewViewController.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 03/09/2018.
//  Copyright © 2018 MiTo Creative. All rights reserved.
//

import UIKit
import Foundation

class UnderViewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, XMLParserDelegate {

    @IBOutlet var collectionView2: UICollectionView!

    var currentParsingElement:String = ""
    var array = ["Data"]
    var index = 0
    var logg = ""
    var number = ""
    var key: String = ""
    var attribute: String = ""
    var attributes: String = ""
    var category = NSMutableDictionary()
    var iPhone = NSMutableDictionary()
    var Mac = NSMutableDictionary()
    var Watch = NSMutableDictionary()
    var iPad = NSMutableDictionary()
    var TV = NSMutableDictionary()
    var test:String = ""
    var test2: String = ""
    var kunde: String = ""
    var temp: String = ""
    var bilder = [UIImage]()
    var text = [String]()
    var images = [String]()
    var headline = [String]()
    var link = [String]()
    var teste = [String]()

    
    
    var valgt: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        headline.removeAll()
        images.removeAll()
        link.removeAll()
        attributes.removeAll()
        attribute.removeAll()

        self.title = valgt
        
        getXMLDataFromServer()
        getCategory()
        
        // Remove all cache
        URLCache.shared.removeAllCachedResponses()
        
        // Delete any associated cookies
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
        
       
        print(valgt)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        headline.removeAll()
        images.removeAll()
        link.removeAll()
        attributes.removeAll()
        attribute.removeAll()
        
        self.title = valgt
        
        getXMLDataFromServer()
        getCategory()
        
        
        print(valgt)
        
    }
    
    
    
    func getXMLDataFromServer(){
        
       
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var aString = appDelegate.urlString
        
        aString += "product1.xml"
        
        let url = NSURL(string: aString)
        
        
        //Creating data task
        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            
            if data == nil {
                print("dataTaskWithRequest error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            let parser = XMLParser(data: data!)
            parser.delegate = self
            parser.parse()
            
        }
        
        task.resume()
        
        
        
    }
    
    func getCategory(){
        

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var aString = appDelegate.urlString
        
        aString += "images1.xml"
        
        let url = NSURL(string: aString)
        
        
        //Creating data task
        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            
            if data == nil {
                print("dataTaskWithRequest error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            let parser = XMLParser(data: data!)
            print(data!)
            parser.delegate = self
            parser.parse()
            
            
            
        }
        
        task.resume()
        
    }
    
    
    
    
    //MARK:- XML Delegate methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentParsingElement = elementName
       
        
        if elementName == "file" {
            print("Started parsing...")
            
        }

        if elementName == "product" {
            
            let dict = NSMutableDictionary(dictionary: attributeDict)
            
            let enumerator = dict.keyEnumerator()
            
            while let key = enumerator.nextObject() {
                let value = dict.object(forKey: key)
                
                attribute = value as! String
            }
        }
        
        
        if elementName == "images" {
            
            let dict = NSMutableDictionary(dictionary: attributeDict)
            
            let enumerator = dict.keyEnumerator()
            
            while let key = enumerator.nextObject() {
                let value = dict.object(forKey: key)
                
                attributes = value as! String
            }
        }
        
        
       
        
   
        
        
        
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let foundedChar = string.trimmingCharacters(in:NSCharacterSet.whitespacesAndNewlines)
       
        
        
        if (!foundedChar.isEmpty) {
            
            if currentParsingElement == "category"{
                temp = foundedChar
                
                if temp == valgt {
                
                headline.append(attribute)
                }
        
            }
            
            
            if currentParsingElement == "link" {
                kunde = foundedChar
                
                
                
                if kunde.range(of:valgt) != nil {
                    print("exists")
                    
                    link.append(kunde)
                }
                
                
          
            }
            
            if currentParsingElement == "img" {
                temp = foundedChar
                
                print("temp")
                print(temp)
                
                
                let lowercased = valgt.lowercased()
                
              
                if temp.lowercased().range(of:lowercased) != nil {
                    
                    print("exists")
                    images.append(temp)
                    
                }
                else{
                    print("Did not find string in valgt")
                }
                
               
                
                
            }
            temp = ""
            kunde = ""
            
            
            
        }
        else{
//            print("error")
            //print(currentParsingElement)
            
        }
        
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "file" {
            print("Ended parsing...")
            
            print(headline)
            print(link)
            print(images)
            
            
            
        }
        
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.async {
            // Update UI
            
            //let number = self.headline.count
            
            
            
            
        }
        
        
        
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headline.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell2", for: indexPath) as! ProductsCollectionViewCell
        
        var image = UIImage(named:"globe@2x.png")
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var astring = appDelegate.urlString
        
        if images.count < headline.count {
            
            
            
            while images.count != headline.count{
                

            images.append("questionmark.png")
            }
            
        }
        
        astring += self.images[indexPath.row]
        
        
        let url = URL(string: astring)
        
        
        if let data = try? Data(contentsOf: url!)
        {
            image = UIImage(data: data)!
          
        }
        else {
            print("error")
        }
        
     
        cell.displayContent(image: image!, title: headline[indexPath.row])
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("pressed")
        
        test = link[indexPath.row]
        test2 = headline[indexPath.row]
        
        self.performSegue(withIdentifier: "toProductPage", sender: self)

        
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toProductPage") {
            print("segue moved")
            if let destinationVC = segue.destination as? ProductPageViewController {
                destinationVC.address = test
                destinationVC.headline = test2
            }
        }
        }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

