//
//  SingleRestaurant.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 12/2/21.
//

import SwiftUI

struct SingleRestaurant: View {
	@ObservedObject var fetcher: RestaurantFetcher
	var address: String

	func load(){
		fetcher.loadDocuMenu(address: address)
	}

	var body: some View {
		GeometryReader { geometry in
			VStack{
				if(fetcher.restaurantWithMenu.count > 0){
					Text(fetcher.restaurantWithMenu[0].restaurantName)
					List {
						ForEach(fetcher.restaurantWithMenu[0].menus, id: \.self) { menu in
							ForEach(menu.menuSections, id: \.self) { menuSection in
								Text(menuSection.sectionName).bold()
								ForEach(menuSection.menuItems, id: \.self) { item in
									VStack(alignment: .leading) {
										HStack {
											Text(item.name)
											Spacer()
											Text(String(item.price) + "$")

										}
										Spacer()
										Text(item.description).font(.caption).foregroundColor(.green)
									}
								}
							}
						}
					}
				} else {
					ActivityIndicator().foregroundColor(.green)
				}
			}.onAppear(perform: load)
		}

	}
}

struct SingleRestaurant_Previews: PreviewProvider {
	static var previews: some View {
		SingleRestaurant(fetcher: RestaurantFetcher(), address: "552 Green St")
	}
}
