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
                self.loading = false
            } else {
                self.email = ""
                self.password = ""
                print("success")
                self.loading = false
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
    var body: some View{
        NavigationView{
            VStack() {
                Text("Sign Up")
                    .font(.largeTitle).foregroundColor(Color.white)
//                    .padding([.top,.bottom], 20)
                    .shadow(radius: 10.0, x: 20, y: 10)
                
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Email", text: self.$email)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.signU)
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    
                    SecureField("Password", text: self.$password)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.signU)
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                }.padding([.leading, .trailing], 27.5)
                
                Button(action: { signup() }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color(ColorCodes().drv))
                        .cornerRadius(15.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                }.padding(.top, 50)
                Spacer()
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(ColorCodes().mauve), Color(ColorCodes().pur)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
        }
    }
}

extension Color {
    static var signU: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp(session: SessionStore())
    }
}
