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
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    SignInIllustration()
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)

                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    RememberForgotView( selection: selection,session: session)
                    if authenticationFailed {
                        Text("Information not correct. Try again.")
                            .offset(y: 5)
                            .foregroundColor(.red)
                    }
                    Button(action: { login() }) {
                        Text("Sign in")
                    }.offset(y: 30)
                    Spacer()
                    NavigationLink(destination: SignUp(session: session), tag: "Sign Up", selection: $selection) {
                        HStack {
                            Button {
                                self.selection = "Sign Up"
                            } label: {
                                Text("Not signed up yet!?")
                            }
                        }.padding(.bottom)
                            .foregroundColor(.red)
                    }
                }
                .padding()
                .navigationBarTitle("Log in").multilineTextAlignment(.leading)
            }
        }
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
                    Text("Forgot password")
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
