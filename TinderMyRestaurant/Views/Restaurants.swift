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
	@GestureState var translation: CGSize = .zero


	var body: some View {
		let dragGesture = DragGesture().updating($translation) { value, state, _ in
			state = value.translation
		}

		VStack {
			TopView(session: session, fetcher: fetcher, locationManager: locationManager)
			NavigationView {
				VStack{
					GeometryReader { geometry in
						if(fetcher.restaurantWithMenu.count > 0){
							ForEach(fetcher.restaurantWithMenu.shuffled().indices, id: \.self) { index in
								let restaurant = fetcher.restaurantWithMenu[index]
								VStack {
									RestaurantCard(restaurant: restaurant)
										.animation(.interactiveSpring())
										.offset(x: self.translation.width, y: 0)
										.rotationEffect(.degrees(Double(self.translation.width / geometry.size.width)*25), anchor: .bottom)
										.gesture(dragGesture.onEnded({ value in
											let direction = detectDirection(value: value)
											if(direction == .left){
												fetcher.restaurantWithMenu = fetcher.restaurantWithMenu.filter { resta in
													resta.restaurantName != restaurant.restaurantName
												}
											}
											if(direction == .right){
												self.selection = restaurant.restaurantId
											}
										}))
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
									}
									}
								}.background(
                                    LinearGradient(gradient: Gradient(colors: [Color(ColorCodes().drv), Color(ColorCodes().rv)]), startPoint: .top, endPoint: .bottom)
								)
							}
						} else {
							ActivityIndicator()
								.foregroundColor(.green)
						}
					}
				}.navigationBarHidden(true)
					.navigationBarTitle("Restaurants")
					.navigationViewStyle(StackNavigationViewStyle())
					.statusBar(hidden: true)
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
