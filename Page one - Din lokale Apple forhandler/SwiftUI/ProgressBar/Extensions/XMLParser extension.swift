//
//  XMLParser extension.swift
//  Page one - SwiftUI
//
//  Created by Jon Mikael Skaug on 07/06/2022.
//

import Foundation

extension XMLParser: XMLParserDelegate {
    
    public func startParsingWithContentsOfURL(rssURL: URL){
        let parser = XMLParser(contentsOf: rssURL)
        parser?.delegate = self
        parser?.parse()
    }
    
    //MARK:- XML Delegate methods
    
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
  
        parseElements().currentParsingElement = elementName
        print(elementName)
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

    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        let foundedChar = string.trimmingCharacters(in:NSCharacterSet.whitespacesAndNewlines)
        
        
        if (!foundedChar.isEmpty) {
            
            item.setValue(foundedChar, forKey: attribute)
            
        }
        
        
        
    }

    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "fmresultset" {
            print("Ended parsing...")
     
        }
        
        
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        
        if (item.object(forKey: "Deler") != nil){
        tekst = item.object(forKey: "Deler") as! String
        }
        else{
            tekst = "Beklager. Vi finner ingen serviceordre."
        }
    }
    
}








