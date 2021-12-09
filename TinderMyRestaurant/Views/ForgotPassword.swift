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
			VStack(){
				Text("Forgot Password")
					.font(.largeTitle).foregroundColor(Color.white)
					.padding([.top,.bottom], 20)
					.shadow(radius: 10.0, x: 20, y: 10)
				VStack(alignment: .leading, spacing: 15) {
					TextField("Email", text: self.$email)
						.autocapitalization(.none)
						.padding()
						.background(Color.forgotP)
						.cornerRadius(20.0)
						.shadow(radius: 10.0, x: 20, y: 10)
				}.padding([.leading, .trailing], 27.5)
				Button(action: { reset() ;self.showingAlert.toggle()}) {
					Text("Reset Password")
						.font(.headline)
						.foregroundColor(.white)
						.padding()
						.frame(width: 300, height: 50)
						.background(Color(ColorCodes().drv))
						.cornerRadius(15.0)
						.shadow(radius: 10.0, x: 20, y: 10)
				}
				.alert(isPresented: self.$showingAlert){
					Alert(title: Text("Alert"), message: Text("Reset password link has been sent"))
				}
				.padding(.top, 50)
				Spacer()
			}
			.background(
				LinearGradient(gradient: Gradient(colors: [Color(ColorCodes().mauve), Color(ColorCodes().pur)]), startPoint: .top, endPoint: .bottom)
					.edgesIgnoringSafeArea(.all))
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

extension Color {
	static var forgotP: Color {
		return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
	}
}
