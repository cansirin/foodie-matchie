//
//  TopView.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 11/30/21.
//

import SwiftUI
import MapKit

struct TopView : View {
	@State private var isLoggedIn = false
	@State private var navigationIsShowing = false
	@ObservedObject var session: SessionStore
	@ObservedObject var fetcher: RestaurantFetcher
	@ObservedObject var locationManager: LocationManager
//    let drv = UIColor(red: 0.06, green: 0.00, blue: 0.17, alpha: 1.00)
    
	var body : some View{
		HStack{
			Spacer()
			
            Text("FoodieMatchie").bold().font(.largeTitle).foregroundColor(.white)

			Spacer()
			if(session.session != nil){
                SettingsIcon(session: session, fetcher: fetcher, locationManager: locationManager)
			} else {
				LoginIcon(session: session)
			}

        }.padding().background(Color(ColorCodes().drv))
	}
}

struct SettingsIcon: View {
	@State private var isActive = false
    var session: SessionStore
    var fetcher: RestaurantFetcher
	var locationManager: LocationManager
    
	var body: some View {
		Button(action: {
			self.isActive.toggle()
		}) {
			Image(systemName: "gearshape").resizable().frame(width: 35, height: 35)
		}.foregroundColor(.gray).sheet(isPresented: $isActive) {
            Settings(sessionStore: session, fetcher: fetcher, locationManager: locationManager)
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
