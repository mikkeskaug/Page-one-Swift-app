//
//  SaveContactsViewController.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 28/11/2021.
//  Copyright © 2021 MiTo Creative. All rights reserved.
//

import UIKit
import ContactsUI
import Contacts
import SwiftUI
import MessageUI
import StoreKit



class SaveContactsViewController: UIViewController, MFMailComposeViewControllerDelegate, UIPopoverPresentationControllerDelegate {
    
    
    var product_id: String?
    
    
    @IBOutlet var iapView: UIView!
    
    let defaults = UserDefaults.standard
    var lastName = [String]()
    var firstName = [String]()
    var telefon = [String]()
    var email = [String]()
    var dct = Dictionary<String, Array<String>>()
    var kontakter = CNContact()

    override func viewDidLoad() {
        product_id = "contactsaverpageone"
            super.viewDidLoad()
        

      
        
    }
    
   
    
   
   
  
    
    
    @IBAction func moveAllContacts(_ sender: Any) {

            self.fetchContacts()
 
            print(lastName)
            print(firstName)
            print(telefon)
        
            createCSV()
            
        
        
        
    }
    
    @IBAction func moveContactsFromGroup(_ sender: Any) {
        
        do{
       try shareContacts(contacts: createContact())
        }
        catch {
            print("error")
        }
    }
    
    func fetchContacts() {
        
        let contactStore = CNContactStore()
        var contacts = [CNContact]()
        let keys = [
                CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                        CNContactPhoneNumbersKey,
                        CNContactEmailAddressesKey
                ] as [Any]
     
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request){ [self]
                    (contact, stop) in
                // Array containing all unified contacts from everywhere
                contacts.append(contact)
                self.dct.updateValue([], forKey: contact.identifier)
                self.lastName.append(contact.familyName)
                print(self.lastName)
                self.firstName.append(contact.givenName)
                self.dct[contact.identifier]!.append(contact.givenName)
                self.dct[contact.identifier]!.append(contact.familyName)
                
                if (contact.phoneNumbers.isEmpty){
                    self.telefon.append(" ")
                    
                }
                
                
                
               
            }
             
        } catch {
            print("unable to fetch contacts")
        }
    }
    
    func createCSV() {
        
        var csvString = String()
       
        
        for (key, value) in dct {
            print("(\(key),\(value))")
            let string = "\(String(describing: value))\n"
            print(string)
            let string2 = string.replacingOccurrences(of: "[", with: "")
            let string3 = string2.replacingOccurrences(of: "]", with: "")
            csvString = csvString.appending(string3)
        }
       
         var filesToShare = [Any]()
            let fileManager = FileManager.default
            do {
                let path = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
                let fileURL = path.appendingPathComponent("ContactsCSV.csv")
                // Add the path of the file to the Array
                
                try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
                
                
                filesToShare.append(fileURL)
                
            } catch {
                print("error creating file")
            }
        
        
        
        //let fileURL = NSURL(fileURLWithPath: "ContactsVCF.csv")

 

        // Make the activityViewContoller which shows the share-view
        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)

        activityViewController.popoverPresentationController?.delegate = self
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        activityViewController.modalPresentationStyle = .popover
        activityViewController.popoverPresentationController?.sourceRect = .zero
        // Show the share-view
        self.present(activityViewController, animated: true, completion: nil)
        

        
                   
        
        }
    
    func createContact() -> [CNContact] {

        let contactStore = CNContactStore()
        var contacts = [CNContact]()
        
        let fetchRequest = CNContactFetchRequest(keysToFetch:[CNContactVCardSerialization.descriptorForRequiredKeys()])
        
       
            do {
                
                
                try contactStore.enumerateContacts(with: fetchRequest) {
                    (contact123, stop) in
                    // Array containing all unified contacts from everywhere
                    contacts.append(contact123)}
                
            }
            catch {
                print("unable to fetch contacts")
            }
        
            return contacts
        
    }
    
    func shareContacts(contacts: [CNContact]) throws {
        
        guard let directoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
                return
            }
        var filesToShare = [Any]()
        

            let fileURL = directoryURL.appendingPathComponent("ContactsVCF.vcf")

            let data: Data
            do {
                data = try CNContactVCardSerialization.data(with: contacts)
                
                

                do {
                    try data.write(to: fileURL)
                    filesToShare.append(fileURL)
                }
                catch {
                    print("error\(error)")
                }
            }
            catch {
                print("error\(error)")
            }
        
        // Make the activityViewContoller which shows the share-view
        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)

        
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        activityViewController.modalPresentationStyle = .popover
        activityViewController.popoverPresentationController?.sourceRect = .zero
        // Show the share-view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
  

}
