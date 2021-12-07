//
//  RestaurantCard.swift
//  RestaurantTinder
//
//  Created by Can Sirin on 11/30/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct RestaurantCard: View {
	//	@State private var translation: CGSize = .zero
	let restaurant: DocuMenuRestaurant

	@GestureState var translation: CGSize = .zero

	var body: some View {

		let dragGesture = DragGesture().updating($translation) { value, state, _ in
			state = value.translation
		}

		GeometryReader { geometry in
			VStack {
				Text(restaurant.restaurantName)
					.font(.title).bold().preferredColorScheme(.light).padding()

				WebImage(url: URL(string: "http://s3-media2.fl.yelpcdn.com/bphoto/MmgtASP3l_t4tPCL1iAsCg/o.jpg"))
					.resizable()
					.frame(width: geometry.size.width, height: geometry.size.height / 2)
					.aspectRatio(contentMode: .fit)

				VStack(alignment: .leading, spacing: 10, content: {
					HStack{ // address of the restaurant
						Image(systemName: "house.circle").font(.title).foregroundColor(.green)
						Text(restaurant.address.street)
							.font(.headline).preferredColorScheme(.light)
					}
					HStack{ // rating of the restaurant
						Image(systemName: "star.circle").font(.title).foregroundColor(.green)
						Text("4 star")
							.font(.headline).preferredColorScheme(.light)
					}
					HStack{ // distance to user's location
						Image(systemName: "figure.walk.circle").font(.title).foregroundColor(.green)
//						Text(String(format: "%.2f", restaurant.distance * 0.000621371) + " mile ")
//							.font(.headline).preferredColorScheme(.light)
					}
//					HStack{ // phone number
//						Image(systemName: "phone.circle").font(.title).foregroundColor(.green)
//						Text(restaurant.restaurantPhone)
//							.font(.headline).preferredColorScheme(.light)
//					}
					HStack{ // price tag
						Image(systemName: "dollarsign.circle").font(.title).foregroundColor(.green)
						Text("\(restaurant.priceRangeNum)$")
							.font(.headline).preferredColorScheme(.light)
						Spacer()
					}
				}).padding()

			}
			.overlay(Divider(), alignment: .top)
			.overlay(Divider(), alignment: .bottom)
			.padding(.bottom)
			.background(Color.white)
//			.cornerRadius(10.0)

			.shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
			.shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
			.animation(.interactiveSpring())
			.offset(x: self.translation.width, y: 0)
			.rotationEffect(.degrees(Double(self.translation.width / geometry.size.width)*25), anchor: .bottom)
			.gesture(dragGesture)
		}
	}
}

struct RestaurantCard_Previews: PreviewProvider {
	static var previews: some View {
		RestaurantCard(restaurant: DocuMenuRestaurant(restaurantId: 1, restaurantName: "Can's Place", restaurantPhone: "555 431 33 22", priceRangeNum: 1, address: Address(city: "Denizli", state: "CA", postalCode: "94608", street: "Christie", formatted: "6399 Christie Ave, CA 94608"), cuisines: [], menus: [], geo: Coordinate(lat: 37.89, lon: -122.37)))
	}
}
