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
	let restaurant: Restaurant

	@GestureState var translation: CGSize = .zero

	var body: some View {

		let dragGesture = DragGesture().updating($translation) { value, state, _ in
			state = value.translation
		}

		GeometryReader { geometry in

			VStack {
				Text(restaurant.name)
					.font(.title).bold().preferredColorScheme(.light).padding()

				WebImage(url: URL(string: restaurant.imageUrl))
					.resizable()
					.frame(width: geometry.size.width, height: geometry.size.height / 2)
					.aspectRatio(contentMode: .fit)

				VStack(alignment: .leading, spacing: 10, content: {
					HStack{ // address of the restaurant
						Image(systemName: "house.circle").font(.title).foregroundColor(.green)
						Text(restaurant.location.address1!)
							.font(.headline).preferredColorScheme(.light)
					}
					HStack{ // rating of the restaurant
						Image(systemName: "star.circle").font(.title).foregroundColor(.green)
						Text(String(Int(restaurant.rating)) + " star")
							.font(.headline).preferredColorScheme(.light)
					}
					HStack{ // distance to user's location
						Image(systemName: "figure.walk.circle").font(.title).foregroundColor(.green)
						Text(String(format: "%.2f", restaurant.distance * 0.000621371) + " mile ")
							.font(.headline).preferredColorScheme(.light)
					}
					HStack{ // phone number
						Image(systemName: "phone.circle").font(.title).foregroundColor(.green)
						Text(restaurant.displayPhone)
							.font(.headline).preferredColorScheme(.light)
					}
					HStack{ // price tag
						Image(systemName: "dollarsign.circle").font(.title).foregroundColor(.green)
						Text(restaurant.price)
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

//			.shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
//			.shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
			.animation(.interactiveSpring())
			.offset(x: self.translation.width, y: 0)
			.rotationEffect(.degrees(Double(self.translation.width / geometry.size.width)*25), anchor: .bottom)
			.gesture(dragGesture)
		}
	}
}

struct RestaurantCard_Previews: PreviewProvider {
	static var previews: some View {
		RestaurantCard(restaurant: Restaurant(id: "1", name: "Carl", isClosed: true, imageUrl: "http://s3-media2.fl.yelpcdn.com/bphoto/MmgtASP3l_t4tPCL1iAsCg/o.jpg", rating: 5, displayPhone: "234 234 55", distance: 55.0, location: Location(city: "", country: "", state: "", address1: "", zip_code: ""), price: "10"))
	}
}
