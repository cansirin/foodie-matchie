//
//  Restaurants.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 11/30/21.
//

import SwiftUI

struct Restaurants: View {
	@ObservedObject var fetcher: RestaurantFetcher
	@ObservedObject var session: SessionStore
	@ObservedObject var locationManager: LocationManager
	@State private var selection: String? = nil


	var body: some View {
		VStack {

			TopView(session: session)
			NavigationView {
				VStack{
					GeometryReader { geometry in
						if(fetcher.restaurants.count > 0){
							ForEach(fetcher.restaurants.indices, id: \.self) { index in
								let restaurant = fetcher.restaurants[index]
								VStack {
									RestaurantCard(restaurant: restaurant)
										.animation(.spring()).padding(.bottom)

									Spacer()

									NavigationLink(destination: SingleRestaurant(fetcher: fetcher, address: restaurant.location.address1!), tag: restaurant.location.address1!, selection: $selection) {	HStack {
										Button {
											self.selection = nil
											fetcher.restaurants.remove(at: index)
										} label: {
											Image(systemName: "xmark.circle").foregroundColor(.red).font(.system(size: 52))
										}
										Button {
											self.selection = restaurant.location.address1
										} label: {
											Image(systemName: "heart.circle").foregroundColor(.green).font(.system(size: 52))
										}
									}.padding(.bottom)
									}
								}
							}
						} else {
							ActivityIndicator()
								.foregroundColor(.green)
						}
					}
				}.navigationBarHidden(true)
					.navigationBarTitle("Restaurants")
					.edgesIgnoringSafeArea([.top, .bottom])
				//				HStack {
				//					Button {
				//						self.selection = nil
				//					} label: {
				//						Image(systemName: "xmark.circle").foregroundColor(.red).font(.system(size: 52))
				//					}
				//					Button {
				//						self.selection = "542 Green St"
				//					} label: {
				//						Image(systemName: "heart.circle").foregroundColor(.green).font(.system(size: 52))
				//					}
				//
				//				}
				//				.padding(.top)

				//				LikeAndDislikeButtons()
			}.onAppear {
				fetcher.loadYelpAPI(latitude: locationManager.lastLocation.latitude, longitude: locationManager.lastLocation.longitude)
			}
		}
	}
}

struct LikeAndDislikeButtons: View {
	var body: some View {
		HStack {
			Button {
				print("Edit button was tapped")
			} label: {
				Image(systemName: "xmark.circle").foregroundColor(.red).font(.system(size: 52))
			}
			Button {
				print("Edit button was tapped")
			} label: {
				Image(systemName: "heart.circle").foregroundColor(.green).font(.system(size: 52))
			}

		}
		.padding(.top)
	}
}

struct Restaurants_Previews: PreviewProvider {
	static var previews: some View {
		Restaurants(fetcher: RestaurantFetcher(), session: SessionStore(), locationManager: LocationManager())
	}
}
