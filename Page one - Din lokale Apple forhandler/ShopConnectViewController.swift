//
//  ShopConnectViewController.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 13/04/2020.
//  Copyright © 2020 MiTo Creative. All rights reserved.
//

import UIKit


class ShopConnectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var MyCollectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
       
    
    @IBOutlet weak var MyCollectionViewCell: UICollectionViewCell!
    
    var images2 = [Array<Any>]()
    var dict = [String: String]()
    var nameArray = [String]()
    var idArray = [Int]()
    var priceArray = [String]()
    var permalinkArray = [String]()
    var imgURLArray = [URL]()
  
    let seconds = 2.0
    var sentUrl = String()
    
    override func viewDidAppear(_ animated: Bool) {

        
        loadData()
        
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if !UIDevice.current.isCatalystMacIdiom {
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
            MyCollectionView.alwaysBounceVertical = true
            MyCollectionView.refreshControl = refreshControl // iOS 10+
        }
        
       
        
       
       

}
    
    
    
    struct Products: Codable {
      let id: Int
      let name: String
      let price: String
      let images: [Images]
        let permalink: String
    }

    struct Images: Codable {
        let name: String
        let id: Int
        let src: String
        
    }
    
    
    
    func loadData () {
        
        let username = "ck_0b8e854656850f88a5c009e92fce4b86f455820f"
        let password = "cs_746801f8ca71f57c5b6aa9a95cb7e042d13bed12"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()

        let request = NSMutableURLRequest(url: NSURL(string: "https://pageone.no/wp-json/wc/v3/products?category=305")! as URL)
        let session = URLSession.shared
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         request.addValue("application/json", forHTTPHeaderField: "Accept")
           
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if let data = data {
              
                do {
     
                let parsedJSON = try JSONDecoder().decode([Products].self, from: data)
                    
                 
                   
                    parsedJSON.forEach { Products in self.idArray.append(Products.id) }
                    
                    parsedJSON.forEach { Products in self.nameArray.append(Products.name)}
                    
                    parsedJSON.forEach { Products in self.priceArray.append(Products.price) }
                    
                    parsedJSON.forEach { Products in self.images2.append(Products.images) }
                    
                    parsedJSON.forEach { Products in self.permalinkArray.append(Products.permalink) }
 
                   
                    for i in 0 ..< self.images2.count {
                        
                        let temp = self.images2[i]
                     
                        
                        
                        if temp.isEmpty == false {
                            
                            let tempString = "\(temp[0])"
                            
                            
                            let finalResult = self.checkForUrls(text: tempString)
                           
                            if finalResult.isEmpty == false {
                            self.imgURLArray+=finalResult
                            }
                            else {
                                let tempURL = URL(fileURLWithPath: "https://pageone.no/wp-content/uploads/2021/11/placeholder-image.png")
                                self.imgURLArray.append(tempURL)
                            }
                                      
                          }
                        else {
                            
                        }
                        
                    }
                
                   
                    DispatchQueue.main.async {
                        self.MyCollectionView.reloadData()
                      
                    }
             
                        } catch {
                
                            
                        }
                    
                
              
            }
     
            
            
        })
        
      
        
           task.resume()
        

    
    }
    
    func checkForUrls(text: String) -> [URL] {
        let types: NSTextCheckingResult.CheckingType = .link

        do {
            let detector = try NSDataDetector(types: types.rawValue)

            let matches = detector.matches(in: text, options: .reportCompletion, range: NSMakeRange(0, text.count))
        
            return matches.compactMap({$0.url})
        } catch let error {
            //debugPrint(error.localizedDescription)
        }

        return []
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        // Do you your api calls in here, and then asynchronously remember to stop the
        // refreshing when you've got a result (either positive or negative)
        
        self.nameArray.removeAll()
        self.imgURLArray.removeAll()
        self.priceArray.removeAll()
        self.idArray.removeAll()
        self.sentUrl.removeAll()
        self.images2.removeAll()
        self.permalinkArray.removeAll()
        loadData()
        
        DispatchQueue.main.async {
            
            self.MyCollectionView.reloadData()
          
        }
        
        refreshControl.endRefreshing()
    }
    
    
    
    // MARK: - UICollectionViewDataSource protocol
        
        // tell the collection view how many cells to make
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
         
            
            return self.idArray.count
            
            
        }
        
        // make a cell for each cell index path
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.myLabel.text = self.nameArray[indexPath.row] // The row value is the same as the index of the desired text within the array.
            cell.priceLabel.text = self.priceArray[indexPath.row]
           
            let temp = self.imgURLArray[indexPath.row]
            
          
           
            // Fetch Image Data
            if let data = try? Data(contentsOf: temp) {
                    // Create Image and Update Image View
                
                cell.productImage.image = UIImage(data: data)
                }
            
            
            cell.backgroundColor = UIColor.white // make cell more visible in our example project
            
            
            return cell
        }
        
        // MARK: - UICollectionViewDelegate protocol
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // handle tap events
            
            
            let SelectedItem = indexPath.row
                //print(SelectedItem)
            
                sentUrl = permalinkArray[SelectedItem]
            
                performSegue(withIdentifier: "productSegue", sender: self)
                
            
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "productSegue") {
           
           
            if let detailVC = segue.destination as? ShowProductPageViewController {
               
                
               
                detailVC.sentUrl = sentUrl
                
               
               
            }
    }
        
    }
    
    


}

extension UIDevice {
    /// Checks if we run in Mac Catalyst Optimized For Mac Idiom
    var isCatalystMacIdiom: Bool {
        if #available(iOS 14, *) {
            return UIDevice.current.userInterfaceIdiom == .mac
        } else {
            return false
        }
    }
}

