//
//  ContactView.swift
//  Page one - SwiftUI
//
//  Created by Jon Mikael Skaug on 29/05/2022.
//

import SwiftUI
import Foundation
import MessageUI
import UIKit

struct ContactView: View {
    @State private var name: String = ""
    @State private var number: String = ""
    @State private var email: String = ""
    @State private var profileText = ""
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State private var showingAlert = false
    let strNumber = "33361100"
    
    var body: some View {
        NavigationView {
         
            VStack {
                VStack(alignment: .center, spacing: 10){
                    
                    Text("Send oss en e-post:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    if MFMailComposeViewController.canSendMail() {
                        Link("butikk@pageone.no", destination: URL(string: "mailto:butikk@pageone.no")!)
                            .padding(20)
                            .background(Color("PrimaryLabel"))
                            .foregroundColor(Color("SecondaryLabel"))
                            .font(.body)
                            .cornerRadius(20)
                            .shadow(radius: 1.0)
                        
                    }
                    else {
                        Text(.init("butikk@pageone.no"))
                            .accentColor(Color("PrimaryLabel"))
                        
                        
                        
                        
                    }
                }.padding(20).accentColor(.blue)
                
                
                VStack(alignment: .center, spacing: 10){
                    
                    Text("Ring oss:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Link("333 61 100", destination: URL(string: "tel:33361100")!)
                        .padding(20)
                        .foregroundColor(Color("SecondaryLabel"))
                        .font(.body)
                        .background(Color("PrimaryLabel"))
                        .cornerRadius(20)
                        .shadow(radius: 1.0)
                    
                    
                }.padding(20)
                
                
                Spacer()
                
            } //End of VStack
            .navigationTitle(Text("Kontakt oss"))
            
            
        }
        .navigationViewStyle(.stack)
        
    } //End of Body
        
    
    
} //End of view
    

struct MailView: UIViewControllerRepresentable {

    @Binding var isShowing: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var isShowing: Bool
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(isShowing: Binding<Bool>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _isShowing = isShowing
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                isShowing = false
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing,
                           result: $result)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {

    }
}



struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContactView()
            ContactView().preferredColorScheme(.dark)
        }
    }
}
