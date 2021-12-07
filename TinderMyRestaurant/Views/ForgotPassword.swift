//
//  ForgotPassword.swift
//  TinderMyRestaurant
//
//  Created by Vi Dao on 12/6/21.
//

import SwiftUI
import Firebase

struct ForgotPassword : View {
    @ObservedObject var session: SessionStore
    @State var email = ""
    @State var password = ""
    @State var loading = false
    @State var error = ""
    @State var showingAlert = false
    
    var body: some View {
        if(loading){
            ActivityIndicator().foregroundColor(.green)
        } else {
            VStack {
                TextField("Email", text: $email).autocapitalization(.none)
                Button(action: { reset() }) {
                    Text("Reset password!")
                }
                .alert(isPresented: $showingAlert){
                    Alert(title: Text("Title"), message: Text("Email sent"))
                }
                
            }
            .padding()
        }
        
    }
    func reset(){
        if self.email != ""{
            Auth.auth().sendPasswordReset(withEmail: self.email){
                (err) in
                if err != nil{
                    self.error = err!.localizedDescription
                    return
                }
            }
        }
        else{
            self.error = "ERROR"
//            self.showingAlert = true
        }
    }
}

