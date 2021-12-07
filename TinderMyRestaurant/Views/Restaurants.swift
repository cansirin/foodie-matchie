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
	@State private var selection: Int? = nil


	var body: some View {
		VStack {

            TopView(session: session, fetcher: fetcher)
			NavigationView {
				VStack{
					GeometryReader { geometry in
						if(fetcher.restaurantWithMenu.count > 0){
							ForEach(fetcher.restaurantWithMenu.shuffled().indices, id: \.self) { index in
								let restaurant = fetcher.restaurantWithMenu[index]
								VStack {
									RestaurantCard(restaurant: restaurant, fetcher: fetcher)
										.animation(.spring()).padding(.bottom)
									Spacer()

									NavigationLink(destination: SingleRestaurant(locationManager: locationManager, restaurant: restaurant), tag: restaurant.restaurantId, selection: $selection) {	HStack {
										Button {
											self.selection = nil
											fetcher.restaurantWithMenu.remove(at: index)
										} label: {
											Image(systemName: "xmark.circle").foregroundColor(.red).font(.system(size: 48))
										}
										Button {
											self.selection = restaurant.restaurantId
										} label: {
											Image(systemName: "heart.circle").foregroundColor(.green).font(.system(size: 48))
										}
									}.padding()
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
