//
//  SingleRestaurant.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 12/2/21.
//

import SwiftUI

struct SingleRestaurant: View {
	@ObservedObject var locationManager: LocationManager
	@State var restaurant: DocuMenuRestaurant

	var body: some View {
		GeometryReader { geometry in
			VStack{
				Text(restaurant.restaurantName).font(.largeTitle)
				Text(restaurant.address.formatted).font(.subheadline)
				List {
					MapView(latitude: restaurant.geo.lat, longitude: restaurant.geo.lon).frame(width: geometry.size.width, height: geometry.size.height/2)
					ForEach(restaurant.menus, id: \.self) { menu in
						ForEach(menu.menuSections, id: \.self) { menuSection in
							Text(menuSection.sectionName).bold()
							ForEach(menuSection.menuItems, id: \.self) { item in
								VStack(alignment: .leading) {
									HStack {
										Text(item.name)
										Spacer()
										Text("$" + String(item.price))
									}
									Spacer()
									Text(item.description).font(.caption).foregroundColor(.green)
								}
							}
						}
					}
				}
			}
		}
	}
}

struct SingleRestaurant_Previews: PreviewProvider {
	static var previews: some View {

		SingleRestaurant(locationManager: LocationManager(), restaurant: DocuMenuRestaurant(restaurantId: 1, restaurantName: "Can's Place", restaurantPhone: "5555555555", restaurantWebsite: "", priceRangeNum: 1, address: Address(city: "", state: "", postalCode: "", street: "", formatted: ""), cuisines: [], menus: [], geo: Coordinate(lat: 37.89, lon: -122.37)))
}
}
