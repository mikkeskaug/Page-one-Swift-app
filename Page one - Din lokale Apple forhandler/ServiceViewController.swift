//
//  ServiceViewController.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 22.02.2018.
//  Copyright © 2018 MiTo Creative. All rights reserved.
//

import UIKit

class ServiceViewController: UIViewController, UIPageViewControllerDelegate, XMLParserDelegate {
    
//  Create Textfields and buttons for input
    @IBOutlet var serviceOrdreTextField: UITextField!
    @IBOutlet var phoneNumberTextfield: UITextField!
    @IBOutlet var searchBtn: UIButton!
  
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view4: UIView!
    @IBOutlet var ferdigTextLabel2: UILabel!
    @IBOutlet var prisLabel2: UILabel!
    


//  creating an object
    let screenSize: CGRect = UIScreen.main.bounds
    

    
//  Creating variables for boxes and lines
//  Box Venter Deler
    var venterDelerView: UIView!
    var venterDeler: UILabel!
    var venterDelerText: UILabel!
    
//  Box underRep
    var underRepView: UIView!
    var underRep: UILabel!
    var underRepText: UILabel!
    
//  Box ferdig
    var ferdigView: UIView!
    var ferdig: UILabel!
    var ferdigText: UILabel!
    
//  Box klar
    var klarView: UIView!
    var klar: UILabel!
    var klarText: UILabel!
    var fakturaBelop: UILabel!
    
//  Lines
    var line: UIView!
    var line2: UIView!
    var line3: UIView!

    var kunde: String = ""
    
    var currentParsingElement:String = ""
    var array = ["Data"]
    var index = 0
    var logg = ""
    var number = ""
    var key: String = ""
    var attribute: String = ""
    var item = NSMutableDictionary()
    var test:String = ""
    
    
  
    
    
    //weak var parentPageViewController: PageViewController?
    
//  View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchStatus(_ sender: Any) {
         item.removeAllObjects()
       
        print("Button tapped")
        self.view1.isHidden = true
        self.view2.isHidden = true
        self.view3.isHidden = true
        self.view4.isHidden = true
        
        //  Checking to see if textfields are empty
        if serviceOrdreTextField.text == "" && phoneNumberTextfield.text == ""  {
            
            //Creating an alert to let user know that textfields are empty
            let alert = UIAlertController(title: "Tomme felter", message: "Begge feltene er tomme, prøv igjen!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                    case .default:
                    print("default")
                    
                    case .cancel:
                    print("cancel")
                    
                    case .destructive:
                    print("destructive")
                    
                
                @unknown default:
                    fatalError()
                }
            }))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        else if serviceOrdreTextField.text == "" {
            //Creating an alert to let user know that textfields are empty
            let alert = UIAlertController(title: "Tomme felter", message: "En av feltene er tomme, prøv igjen!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else if phoneNumberTextfield.text == "" {
            //Creating an alert to let user know that textfields are empty
            let alert = UIAlertController(title: "Tomme felter", message: "En av feltene er tomme, prøv igjen!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    
        else if phoneNumberTextfield.text!.count < 8 {
            let alert = UIAlertController(title: "Feil nummer", message: "Telefonnummeret må inneholde minimum 8 tall", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if phoneNumberTextfield.text!.count > 8 {
            
            let trimmedString = phoneNumberTextfield.text?.replacingOccurrences(of: " ", with: "")
 
            phoneNumberTextfield.text = trimmedString
            logg = serviceOrdreTextField.text!
            number = phoneNumberTextfield.text!
           
            getXMLDataFromServer()
        }
        else{
            
            logg = serviceOrdreTextField.text!
            number = phoneNumberTextfield.text!
            
            getXMLDataFromServer()
            
            
            
            
        }
        
       
        
    }
    
    
    func getXMLDataFromServer(){
        
        let aString = "http://213.239.106.126/fmi/xml/fmresultset.xml?-db=AppleBase&-lay=XML&Loggnummer=LOGG&XMLTelefon=NAVN&-find"
        let newString = aString.replacingOccurrences(of: "LOGG", with: logg, options: .literal, range: nil)
        let newNewString = newString.replacingOccurrences(of: "NAVN", with: number, options: .literal, range: nil)
        
        let url = NSURL(string: newNewString)
        
        
        //Creating data task
        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            
            if data == nil {
                print("dataTaskWithRequest error: \(String(describing: error?.localizedDescription))")
                return
            }
            else {
                
                DispatchQueue.main.async {
                
                }
                
            }
            
            DispatchQueue.main.async {
            let parser = XMLParser(data: data!)
            parser.delegate = self
            parser.parse()
            }
            
        }
        
        task.resume()
        
    }
    
    
    //MARK:- XML Delegate methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentParsingElement = elementName
        if elementName == "fmresultset" {
            print("Started parsing...")
            
        }
        
        if elementName == "field" {
            
            let dict = NSMutableDictionary(dictionary: attributeDict)

            let enumerator = dict.keyEnumerator()
            
            while let key = enumerator.nextObject() {
                let value = dict.object(forKey: key)
                
                attribute = value as! String
            }
            
        }
        
   
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let foundedChar = string.trimmingCharacters(in:NSCharacterSet.whitespacesAndNewlines)
        
        if (!foundedChar.isEmpty) {
            
            if currentParsingElement == "data" {
                kunde = foundedChar
                
               // array.append(kunde)

            }
            
            
            item.setValue(kunde, forKey: attribute)
        }
            else{
                print("error")
                
            }
        
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "fmresultset" {
            print("Ended parsing...")
            print(item)
           
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.async {
            // Update UI
            
            if self.item.object(forKey: "XMLferdig") != nil {
            print("Ferdig")
                
            
            self.view4.isHidden = false
            self.view4.backgroundColor = UIColor.systemGreen
            self.ferdigTextLabel2.text = self.item.object(forKey: "Deler") as? String
                if self.item.object(forKey: "Faktura_belop") != nil {
            self.test = self.item.object(forKey: "Faktura_belop") as! String
            self.prisLabel2.text! = "Å betale: \(self.test)"
                }
                else{
                    self.prisLabel2.text = "Å betale: 0 kr"
                }
                if self.view.frame.size.width >= 800 {
                    self.view4.sizeThatFits(CGSize(width: 350, height: 350))
                }
            
            self.view3.isHidden = false
            self.view3.backgroundColor = UIColor.systemGray
            self.view2.isHidden = false
            self.view2.backgroundColor = UIColor.systemGray
            self.view1.isHidden = false
            self.view1.backgroundColor = UIColor.systemGray
                
              
                
            }
            else if self.item.object(forKey: "XMLunderRep") != nil {
                print("Under reparasjon")
                self.view3.isHidden = false
                self.view3.backgroundColor = UIColor.systemGreen
                self.view2.isHidden = false
                self.view2.backgroundColor = UIColor.systemGray
                self.view1.isHidden = false
                self.view1.backgroundColor = UIColor.systemGray
                
            }
            else if self.item.object(forKey: "XMLventerDeler") != nil {
                print("Venter Deler")
                self.view2.isHidden = false
                self.view2.backgroundColor = UIColor.systemGreen
                self.view1.isHidden = false
                self.view1.backgroundColor = UIColor.systemGray
                
                
            }
            else if self.item.object(forKey: "XMLmottatt") != nil{
                print("Mottatt")
                self.view1.isHidden = false
                self.view1.backgroundColor = UIColor.systemGreen
            }
            else{
            
            let alert = UIAlertController(title: "Ingen treff", message: "Vi fant ingen serviceordre på dette alternativet, prøv igjen!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }
            }
        
        
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
