//
//  MainProductPage.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 23/02/2022.
//  Copyright © 2022 MiTo Creative. All rights reserved.
//

import UIKit
import Foundation
import WebKit

protocol HeroCellDelegate: AnyObject {
    func HeroBuyButtonClicked(_ data: String)
    
}

protocol AktueltCellDelegate: AnyObject{
    func aktueltButtonClicked(_ data: String)
}

protocol AktueltTableDelegate: AnyObject{
    func aktueltButtonClicked2(_ data: String)
        
}

protocol CategoryCellDelegate: AnyObject{
    func categoryClicked(_ data: String, selected: Int)
}

class MainProductPage: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate, HeroCellDelegate, AktueltTableDelegate, CategoryCellDelegate{
    


    var initalSizeNAV = CGFloat()
    var initalSizeHeight = CGFloat()
    var intitalSizeWidth = CGFloat()
    var HeroTableViewVariable = [String]()
    var SecondaryHeroTableViewVariable = [String]()
    var attribute = String()
    var heroornot = Bool()
    var count = 0
    var aktueltDict = Dictionary<Int, [String]>()
    var tempArray = [String]()
    var count2 = 0
    var images = [UIImage]()
    var urlDestionation = String()
    var selection = String()
    var selectedCategory = Int()
    var data = Data()
    
    enum SectionType {
        case heroProduct
        case secondaryProduct
        case aktuelt(dict: Dictionary<Int, [String]>, images: [UIImage])
        case category
    
        var title: String? {
            switch self {
            case .heroProduct:
                return ""
            case .secondaryProduct:
                return ""
            case .aktuelt:
                return "Aktuelt nå"
            case .category:
                return "Kjøp etter kategori"
            
            }
          
        }
    }
    
    func categoryClicked(_ data: String, selected: Int) {
        
        selection = data
        //print(selection)
        selectedCategory = selected
        self.performSegue(withIdentifier: "mpptocategory", sender: self)
    }
    
    
    func HeroBuyButtonClicked(_ data: String) {
        //print("Clocked button!!!!!!!!!")
        
        urlDestionation = data
        //print("URL DESTINATION: ", urlDestionation)
        
        self.performSegue(withIdentifier: "mpptopp3", sender: self)
        
    }
    
    func aktueltButtonClicked2(_ data: String) {
        
       // print("Clocked button!!!!!!!!!")
        
        urlDestionation = data
       // print("URL DESTINATION: ", urlDestionation)
        
        self.performSegue(withIdentifier: "mpptopp3", sender: self)
    }
    
    
    private let tableView:  UITableView = {
        let table = UITableView()
        table.register(HeroTableViewCell.self, forCellReuseIdentifier: HeroTableViewCell.identifier)
        table.register(SecondaryHeroTableViewCell.self, forCellReuseIdentifier: SecondaryHeroTableViewCell.identifier)
        table.register(AktueltTableViewCell.self, forCellReuseIdentifier: AktueltTableViewCell.identifier)
        table.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        table.isUserInteractionEnabled = true
        return table
        
    }()
    
    private var sections = [SectionType]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Søk", style: .plain, target: self, action: #selector(addTapped))
        XMLParser()

    }
    
    @objc func addTapped(){
      
        self.performSegue(withIdentifier: "toSearch", sender: self)
        
    }
    
   
    
    private func configureSections () {
        
        sections.append(.heroProduct)
        sections.append(.secondaryProduct)
        sections.append(.aktuelt(dict: aktueltDict, images: images))
        sections.append(.category)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.isUserInteractionEnabled = true
        
  
    }//End of viewdidlayoutsubviews
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = sections[section]
        return sectionType.title
    }
    
    
    
   
    
    

    // MARK: - Table view data source
    
    

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionType = sections[indexPath.section]
       
        switch sectionType {
       
        case .heroProduct:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HeroTableViewCell.identifier,
                                                           for: indexPath) as? HeroTableViewCell
            else {
                fatalError()
            }
            
            cell.delegate = self
            cell.imageViewer.frame = CGRect(x: 10, y: 0, width: Int(self.view.frame.size.width-20), height: Int(initalSizeHeight-(initalSizeNAV)*3))
            cell.view.frame = CGRect(x: 15, y: Int(cell.imageViewer.frame.height-65), width: Int(intitalSizeWidth)-30, height: 60)
            cell.button.frame = CGRect(x: Int(cell.imageViewer.frame.width-100), y: Int(cell.view.frame.height/2)-15, width: 80, height: 30)
            cell.pricelabel.frame = CGRect(x: 20, y: Int(cell.view.frame.height/2)-15, width: 100, height: 30)
            cell.selectionStyle = .none
            
            //print(HeroTableViewVariable)
            
            cell.describingText.text = HeroTableViewVariable[1]
            cell.textView.text = HeroTableViewVariable[0]
            cell.text = HeroTableViewVariable[5]
            let imageURL = URL(string: HeroTableViewVariable[2])
            
            
            getData(from: imageURL!) { data, response, error in
                guard let data = data, error == nil else { return }
                //print(response?.suggestedFilename ?? imageURL!.lastPathComponent)
                //print("Download Finished")
                // always update the UI from the main thread
                DispatchQueue.main.async() {
                    
                    if self.data == data {
                        //No change to data
                    }
                    else {
                        cell.imageViewer.image = UIImage(data: data)
                    }
                    
                }
            }
            
            cell.pricelabel.text = HeroTableViewVariable[4]
            cell.urlDestination = HeroTableViewVariable[3]
            
            return cell
        case .secondaryProduct:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondaryHeroTableViewCell.identifier,
                                                           for: indexPath) as? SecondaryHeroTableViewCell
            else {
                fatalError()
            }
           
            cell.delegate = self
            cell.imageViewer2.frame = CGRect(x: 10, y: 0, width: Int(self.view.frame.size.width-20), height: Int(initalSizeHeight-(initalSizeNAV)*3))
            cell.view.frame = CGRect(x: 15, y: Int(cell.imageViewer2.frame.height-65), width: Int(intitalSizeWidth)-30, height: 60)
            cell.button.frame = CGRect(x: Int(cell.imageViewer2.frame.width-100), y: Int(cell.view.frame.height/2)-15, width: 80, height: 30)
            cell.pricelabel.frame = CGRect(x: 20, y: Int(cell.view.frame.height/2)-15, width: 100, height: 30)
            cell.selectionStyle = .none
            
            cell.textView.text = SecondaryHeroTableViewVariable[0]
            
            cell.describingText.text = SecondaryHeroTableViewVariable[1]
            cell.text = SecondaryHeroTableViewVariable[5]
            cell.frame.size.height = self.view.frame.size.width*1.2
            
            let imageURL = URL(string: SecondaryHeroTableViewVariable[2])
       
            getData(from: imageURL!) { data, response, error in
                guard let data = data, error == nil else { return }
                //print(response?.suggestedFilename ?? imageURL!.lastPathComponent)
                //print("Download Finished")
                // always update the UI from the main thread
                DispatchQueue.main.async() {
                    if self.data == data {
                        //No change to data
                    }
                    else {
                        cell.imageViewer2.image = UIImage(data: data)
                    }
                }
            }
            
            cell.urlDestination = SecondaryHeroTableViewVariable[3]
            cell.pricelabel.text = SecondaryHeroTableViewVariable[4]
            
            return cell
        case .aktuelt:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AktueltTableViewCell.identifier,
                                                           for: indexPath) as? AktueltTableViewCell
            else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: aktueltDict, images: images)
            return cell
        case .category:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier,
                                                           for: indexPath) as? CategoryTableViewCell
            else {
                fatalError()
            }
            
            cell.delegate = self
            return cell
            
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
       
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(named: "PrimaryLabel")
        header.textLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        header.tintColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let sectionType = sections[indexPath.section]
        switch sectionType {
            
        case .heroProduct:
            return CGFloat(Int(initalSizeHeight-(initalSizeNAV)*3))
        case .secondaryProduct:
            return CGFloat(Int(initalSizeHeight-(initalSizeNAV)*3))
        case .aktuelt:
            var size = 0
            
            if self.view.frame.size.width > 495 {
                size = 575
            }
            else {
                size = Int(self.view.frame.size.width*1.2)
            }
            return CGFloat(size)
        case .category:
            
            return self.view.frame.size.width*2.3
            
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        tableView.reloadData()
        
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        //print("Download Started")
        
    }
    
    func XMLParser() {
        
        let url = NSURL(string: "https://pageone.no/app/storefrontapp.xml")

        let task = URLSession.shared.dataTask(with: url! as URL) {(data, response, error) in
            if data != nil
            {
                
                //print(data!)
                let parser = Foundation.XMLParser(data: data!)
                    parser.delegate = self
                    parser.parse()
            }
            DispatchQueue.main.async {
                self.navigationController?.navigationBar.prefersLargeTitles = true
                self.initalSizeNAV = (self.navigationController?.navigationBar.frame.height)!
                self.initalSizeHeight = self.view.frame.size.height
                self.intitalSizeWidth = self.view.frame.size.width
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
                self.title = "Kjøp"
                self.configureSections()
                self.view.addSubview(self.tableView)
                self.tableView.reloadData()
                
            }
        }
        task.resume()
        
        
    }
    
    // 1
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        if elementName == "HeroTableView"{
            heroornot = true
            count2+=1
            
        }
        else if elementName == "SecondaryHeroTableView"{
            heroornot = false
            count2+=1
        }
        else if elementName == "Aktuelt"{
            count2+=1
        }
        else if elementName == "item"{
            count+=1
            tempArray.removeAll()
           
        }

        
    }

    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "HeroTableView"{
            
  
        }
        else if elementName == "SecondaryHeroTableView"{
            
        }
        else if elementName == "item"{
            aktueltDict[count] = tempArray
            
            tempArray.removeAll()
        }
        else if elementName == "web" {
            //print(aktueltDict)
        }
    }

    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let foundedChar = string.trimmingCharacters(in:NSCharacterSet.whitespacesAndNewlines)

        
        if (!foundedChar.isEmpty) {
            
        if count2 == 1 {
            
           
            HeroTableViewVariable.append(string)
                
        }
            else if count2 == 2 {
                SecondaryHeroTableViewVariable.append(string)
          
            }
            
            else if count2 == 3{
                
                if foundedChar.contains("https://pageone.no/wp-content"){
                    var imageURL = URL(string: "")
                        
                       
                            imageURL = URL(string: string)
                            if let data = try? Data(contentsOf: imageURL!) {
                                    // Create Image and Update Image View
                                //print(data)
                                let image = UIImage(data: data)
                                images.append(image!)
                                
                            }
                            else{
                            //print("error")
                            }
                        }
                        
                       
                
                else {
                tempArray.append(string)
                }
            }
            
        }
        
        
        
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "mpptocategory") {
            let destVC = segue.destination as? CategoryViewController
            destVC?.count = selectedCategory
          
        }
        if (segue.identifier == "mpptopp3"){
                
            let destVC = segue.destination as? ProductPage
            destVC?.link = urlDestionation
    
        }
        if (segue.identifier == "mpptopp") {
            if let destVC = segue.destination as? UINavigationController,
                        let targetController = destVC.topViewController as? ProductPage {
                        targetController.link = urlDestionation
                //print("Funker")
           }
            
        
    
    
    }
    
}

}
