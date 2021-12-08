//
//  ContentView.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 11/30/21.
//

import SwiftUI

struct ContentView: View {

	@ObservedObject var locationManager = LocationManager()
	@ObservedObject var fetcher = RestaurantFetcher()
	@ObservedObject var sessionStore = SessionStore()

	func getUser() {
		sessionStore.listen()
	}

	var body: some View {
		ZStack{
			VStack {
				VStack {
					switch locationManager.authStatus{
						
						case .notDetermined:
							AnyView(LocationRequestView(locationManager: locationManager))

						case .restricted:
							ErrorView(errorText: "Location use is restricted")

						case .denied:
							ErrorView(errorText: "App doesn't have location permissions")

						case .authorizedAlways, .authorizedWhenInUse:
							if(locationManager.lastLocation.latitude == 0 || locationManager.lastLocation.longitude == 0){
								ActivityIndicator().foregroundColor(.green)
							} else {
								Restaurants(fetcher: fetcher, session: sessionStore, locationManager: locationManager).onAppear {
									fetcher.loadMoreRestaurantIfNeeded(currentRestaurant: nil)
								}
							}
						default:
							Text("Unexpected status")
					}
				}
			}
		}.onAppear(perform: getUser)
	}
}



struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView(locationManager: LocationManager(), fetcher: RestaurantFetcher())
	}
}
