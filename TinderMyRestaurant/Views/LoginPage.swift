//
//  LoginPage.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 12/1/21.
//

import SwiftUI

struct LoginPage: View {
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    
    
    @Environment(\.presentationMode) var presentation
    @ObservedObject var session: SessionStore
    @State var email = ""
    @State var password = ""
    @State var loading = false
    @State var error = false
    @State var authenticationFailed = false
    @State var selection: String? = nil
    
    func login() {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.error = true
                self.authenticationFailed = true
            } else {
                self.email = ""
                self.password = ""
                print("success")
                self.authenticationFailed = false
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
    
    
    
    var body: some View {
        NavigationView{
            VStack() {
                Text("Log In")
                    .font(.largeTitle).foregroundColor(Color.white)
                    .padding([.top, .bottom], 30)
                    .shadow(radius: 10.0, x: 20, y: 10)
                
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Email", text: self.$email)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.loginC)
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    
                    SecureField("Password", text: self.$password)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.loginC)
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    RememberForgotView( selection: selection, session: session)
                    if authenticationFailed {
                        Text("Information not correct. Try again.").bold()
                            .offset(x: 30, y: 5)
                            .foregroundColor(.white)
                    }
                }.padding([.leading, .trailing], 27.5)
                
                Button(action: { login() }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color(ColorCodes().drv))
                        .cornerRadius(15.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                }.padding(.top, 30)
                
                Spacer()
                NavigationLink(destination: SignUp(session: session), tag: "Sign Up", selection: $selection){
                    HStack(spacing: 0) {
                        Text("Don't have an account? ").foregroundColor(.white).fontWeight(.heavy)
                        Button(action: {self.selection = "Sign Up"}) {
                            Text("Sign Up")
                                .foregroundColor(.black).fontWeight(.heavy)
                        }
                    }.padding(.bottom, 50)
                }
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
            
        }
    }
    
}

extension Color {
    static var loginC: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(session: SessionStore())
    }
}

struct LoginButton: View {
    var body: some View {
        Text("LOGIN")
            .bold()
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.blue)
            .cornerRadius(15.0)
            .padding(.top, 20)
    }
}

struct RememberForgotView: View {
    @State var selection:String? = nil
    @ObservedObject var session: SessionStore
    var body: some View {
        HStack {
            Spacer()
            NavigationLink(destination: ForgotPassword(session: session), tag: "Forgot password", selection: $selection) {    HStack {
                Button {
                    self.selection = "Forgot password"
                } label: {
                    Text("Forgot password").foregroundColor(.black)
                }
            }
            }}
    }
}


struct SignInIllustration: View {
    var body: some View {
        Image("sign-in")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 300)
            .padding(.bottom, 50)
    }
}
