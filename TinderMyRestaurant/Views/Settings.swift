//
//  Settings.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 12/1/21.
//

import SwiftUI

struct Settings: View {
	@ObservedObject var sessionStore: SessionStore
	@ObservedObject var fetcher: RestaurantFetcher
	@ObservedObject var locationManager: LocationManager
	@State var sliderValue: Double = 5
	@State private var selection: String? = nil

	var body: some View {
		NavigationView{
			VStack{
				Spacer()
					.frame(height: 80)
				Section(header: Text("Account").font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)){
					Image(systemName: "person").resizable().frame(width: 50, height: 50)
					Text(sessionStore.session?.email ?? "").font(.subheadline).foregroundColor(.orange)
//					Text("cansirin12@gmail.com").font(.subheadline).colorInvert()

				}.foregroundColor(.white).frame(width: 300)
					.padding(3)


				Button(action: {
					self.selection = "likedRestaurants"
				}, label: {
					NavigationLink(destination: LikedRestaurants(session: sessionStore), tag: "likedRestaurants", selection: $selection) {
						Text("Liked restaurants ❤️")
					}
				}).foregroundColor(Color.white).padding(10)
					.background(Color(ColorCodes().indigo))
					.cornerRadius(50).padding()

				VStack{
					Text("Settings").font(.title)
					Slider(value: $sliderValue, in: 5...20).accentColor(Color(.white)).background(Color(ColorCodes().indigo)).cornerRadius(30)
					Text("Current distance from you: \(Int(sliderValue))").fontWeight(.heavy)

				}.padding()
					.foregroundColor(Color(.white))

				VStack{
					Button("Save this distance", action: {fetcher.loadDocuMenu(latitude: locationManager.lastLocation.latitude, longitude: locationManager.lastLocation.longitude, distance: Int(sliderValue))}
					).foregroundColor(Color.white).padding(10)
						.background(Color(ColorCodes().indigo))
						.cornerRadius(50).padding()
				}
				Spacer()
				HStack{
					Section(){
						Button("Sign out", action: {
							sessionStore.signOut()
						}).padding()
							.font(.largeTitle)
							.frame(alignment: .center)
							.foregroundColor(Color.white)
					}.frame( alignment: .center)
						.background(Color(ColorCodes().indigo))
						.cornerRadius(30.0)
				}
				Spacer()

			}
			.background(Color(ColorCodes().fv)).ignoresSafeArea()
		}
	}
}

struct Settings_Previews: PreviewProvider {
	static var previews: some View {
		Settings(sessionStore: SessionStore(), fetcher: RestaurantFetcher(), locationManager: LocationManager())
	}
}
