//
//  RestaurantCard.swift
//  RestaurantTinder
//
//  Created by Can Sirin on 11/30/21.
//

import SwiftUI
import SDWebImageSwiftUI
import CoreLocation
import MapKit


struct RestaurantCard: View {
	let restaurant: DocuMenuRestaurant
	@ObservedObject var locationManager: LocationManager

	@GestureState var translation: CGSize = .zero

	func calculateDistance() -> CLLocationDistance {
		let restaurantLocation = CLLocation(latitude: restaurant.geo.lat, longitude: restaurant.geo.lon)
		let distanceInMeters = locationManager.lastLocation.distance(from: restaurantLocation)
		let distanceInMiles = distanceInMeters / 1609
		if (distanceInMiles < 0.2){
			return 0.2
		}
		return distanceInMiles
	}



	var body: some View {
		let price = restaurant.priceRangeNum == 0 ? 1 : restaurant.priceRangeNum
		let rating = String(restaurant.restaurantId).digits[0]
		GeometryReader { geometry in
			VStack {
				Text(restaurant.restaurantName)
					.font(.title).bold().preferredColorScheme(.light).padding()

				WebImage(url: URL(string: "https://source.unsplash.com/1600x900/?restaurant"))
					.resizable()
					.frame(width: geometry.size.width, height: geometry.size.height / 2)
					.aspectRatio(contentMode: .fit)

				VStack(alignment: .leading, spacing: 10, content: {
					HStack{ // address of the restaurant
						Image(systemName: "house.circle").font(.title).foregroundColor(Color(ColorCodes().fv))
						Text(restaurant.address.street)
							.font(.headline).preferredColorScheme(.light)
					}
					HStack{ // rating of the restaurant
						Image(systemName: "star.circle").font(.title).foregroundColor(Color(ColorCodes().fv))
						Text(String(repeating: "⭐️", count: rating))
							.font(.headline).preferredColorScheme(.light)
					}
					HStack{ // distance to user's location
						Image(systemName: "figure.walk.circle").font(.title).foregroundColor(Color(ColorCodes().fv))
						Text(String(format: "%.2f", calculateDistance()) + " mile ")
							.font(.headline).preferredColorScheme(.light)
					}
					HStack{ // price tag
						Image(systemName: "dollarsign.circle").font(.title).foregroundColor(Color(ColorCodes().fv))
						Text(String(repeating: "$", count: price))
							.font(.headline).preferredColorScheme(.light)
						Spacer()
					}
				}).padding()

			}
			.overlay(Divider(), alignment: .top)
			.background(Color(red: 250, green: 250, blue: 250))

			.shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
			.shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
		}
	}
}

struct RestaurantCard_Previews: PreviewProvider {
	static var previews: some View {
		RestaurantCard(restaurant: DocuMenuRestaurant(restaurantId: 1, restaurantName: "Can's Place", restaurantPhone: "555 431 33 22", restaurantWebsite: "", priceRangeNum: 1, address: Address(city: "Denizli", state: "CA", postalCode: "94608", street: "Christie", formatted: "6399 Christie Ave, CA 94608"), cuisines: [], menus: [], geo: Coordinate(lat: 37.89, lon: -122.37)), locationManager: LocationManager())
	}
}


func detectDirection(value: DragGesture.Value) -> SwipeDirection {
	if value.startLocation.x < value.location.x - 24 {
		return .right
	}
	if value.startLocation.x > value.location.x + 24 {
		return .left
	}
	return .none
}

enum SwipeDirection: String {
	case left, right, none
}

extension StringProtocol  {
	var digits: [Int] { compactMap(\.wholeNumberValue) }
}
