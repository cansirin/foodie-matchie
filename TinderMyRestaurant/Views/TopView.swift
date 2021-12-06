//
//  TopView.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 11/30/21.
//

import SwiftUI

struct TopView : View {
	@State private var isLoggedIn = false
	@State private var navigationIsShowing = false
	@ObservedObject var session: SessionStore

	var body : some View{
		HStack{
			Spacer()
			
			Text("FoodieMatchie").bold().font(.largeTitle)


			Spacer()
			if(session.session != nil){
                SettingsIcon(session: session)
			} else {
				LoginIcon(session: session)
			}

		}.padding()
	}
}

struct SettingsIcon: View {
	@State private var isActive = false
    var session: SessionStore
    
	var body: some View {
		Button(action: {
			self.isActive.toggle()
		}) {
			Image(systemName: "gearshape").resizable().frame(width: 35, height: 35)
		}.foregroundColor(.gray).sheet(isPresented: $isActive) {
			Settings(sessionStore: session)
		}
	}
}

struct LoginIcon: View {
	@State private var isActive = false
	var session: SessionStore

	var body: some View {
		Button(action: {
			self.isActive.toggle()
		}) {
			Image(systemName: "person.fill").resizable().frame(width: 35, height: 35)
		}.foregroundColor(.gray).sheet(isPresented: $isActive) {
			LoginPage(session: session)
		}
	}
}
