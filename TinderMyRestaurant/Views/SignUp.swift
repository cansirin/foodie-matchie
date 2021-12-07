//
//  SignUp.swift
//  TinderMyRestaurant
//
//  Created by Vi Dao on 12/6/21.
//

import SwiftUI

struct SignUp: View {
    @ObservedObject var session: SessionStore
    @State var email: String = ""
    @State var password: String = ""
    @State var repass: String = ""
    @State var loading = false
    @State var error = false
    @State var authenticationFailed = false
    @Environment(\.presentationMode) var presentation
    
    func signup() {
        loading = true
        error = false
        session.signUp(email: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.error = true
            } else {
                self.email = ""
                self.password = ""
                print("success")
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
    var body: some View{
        NavigationView{
            ZStack{
                
                VStack(alignment: .center, spacing: 22, content:{
                    //Image
                    SignInIllustration()
                    TextField("Email", text: $email).padding(.leading, 12).font(.system(size: 30)).autocapitalization(.none).background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)).cornerRadius(5.0)
                    SecureField("Password", text: $password).padding(.leading, 12).font(.system(size: 30)).autocapitalization(.none).background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)).cornerRadius(5.0)
                    Button(action: { signup() }) {
                        Text("Sign Up")
                    }
                    
                })
                
                
            }.padding()
            .navigationBarTitle("Sign Up").multilineTextAlignment(.leading)
        }
    }
}
struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp(session: SessionStore())
    }
}
