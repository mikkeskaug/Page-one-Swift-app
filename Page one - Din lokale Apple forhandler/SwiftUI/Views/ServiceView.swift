//
//  ServiceView.swift
//  Page one - SwiftUI
//
//  Created by Jon Mikael Skaug on 29/05/2022.
//

import SwiftUI
import UIKit
import Foundation

class parseElements: ObservableObject {
    @Published var currentParsingElement = ""
    @Published var attribute = ""
    @Published var kunde = ""

}

    var attribute = ""
    var kunde = ""
    var item = NSMutableDictionary()
    var tekst = ""

struct ServiceView: View {
    
    @State private var name: String = ""
    @State private var number: String = ""
    @State var progressValue: Float = 0.0
    @State private var showingPaymentAlert = false
    @State private var presentAlertName = false
    @State private var text = tekst
   
    
    var body: some View {
        NavigationView{
            
        VStack {
            VStack(alignment: .leading, spacing: 20){
            Text("Serviceordre nr:")
                    .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Serviceordre", text: $name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textFieldStyle(.roundedBorder)
            Text("Telefonnummer:")
                        .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Telefonnummer", text: $number)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        
                
            }.padding(20)
            
            
            Button("Søk") {
                searchService()
                self.endTextEditing()
            }
            .padding()
            .frame(width: 100, height: 40, alignment: .center)
            .foregroundColor(Color("SecondaryLabel"))
            .font(.body)
            .background(Color("PrimaryLabel"))
            .cornerRadius(20)
            .shadow(radius: 1.0)
            
            .alert(isPresented: $presentAlertName) { // 4

                        Alert(
                            title: Text("Fyll ut felter"),
                            message: Text("Du må fylle ut begge feltene")
                        )
            }
            
            
            ZStack {
                Color.secondary
                            .opacity(0.1)
                            .edgesIgnoringSafeArea(.all)
                            .background(.thinMaterial)
                            .cornerRadius(30)
                
                    
                        VStack {
                            ProgressBar(progress: self.$progressValue)
                                
                                .padding(30.0)
                       
                            
                            
                        }
                
                Text(text)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(4)
                    .frame(width: 150)
                
            }.padding(5)
            
            
            
           
            
           
        } //End of VStack
            
            
            
        .navigationTitle("Sjekk service status")
        } //End of NavigationView
        .navigationViewStyle(.stack)
    } //End of Body
    
    func incrementProgress(number: Float) {
        let randomValue = Float([number].randomElement()!)
            self.progressValue += randomValue
        }
    
    func searchService () {
        print("Run service search")
        item.removeAllObjects()
        self.progressValue = 0
        if name.isEmpty{
            presentAlertName = true
           
        }
        else if number.isEmpty{
            presentAlertName = true
        }
        else {
            
            let aString = "http://213.239.106.126/fmi/xml/fmresultset.xml?-db=AppleBase&-lay=XML&Loggnummer=LOGG&XMLTelefon=NUMMER&-find"
            let replaced = aString.replacingOccurrences(of: "LOGG", with: name)
            let replaced2 = replaced.replacingOccurrences(of: "NUMMER", with: number)
            print(replaced2)
            
           
            let url = NSURL(string: replaced2)
            
            //Creating data task
            let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
                
                if data == nil {
                    print("dataTaskWithRequest error: \(String(describing: error?.localizedDescription))")
                    return
                }
                else {
                    
                    
                    XMLParser().startParsingWithContentsOfURL(rssURL: url! as URL)
                    
                
                }
                
                
                if item.object(forKey: "XMLferdig") != nil{
                    self.incrementProgress(number: 1)
                    text = "Enheten er ferdig og kan hentes."
                }
                else if item.object(forKey: "XMLunderRep") != nil{
                    self.incrementProgress(number: 0.75)
                    text = "Enheten er nå under reparasjon."
                }
                else if item.object(forKey: "XMLventerDeler") != nil {
                    self.incrementProgress(number: 0.50)
                    text = "Vi venter på deler til reparasjonen."
                }
                else if item.object(forKey: "XMLmottatt") != nil {
                    self.incrementProgress(number: 0.25)
                    text = "Vi har mottatt din enhet og holder på med feilsøking"
                }
                else {
                    text = "Ingen serviceordre funnet"
                }
                
            }
            
            task.resume()
            
            //self.incrementProgress()
        }
        
        
    }
       

              
        
    
    
} //End of view

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView()
        ServiceView().preferredColorScheme(.dark)
    }
}

extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}

