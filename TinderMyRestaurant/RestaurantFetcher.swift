//
//  RestaurantFetcher.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 11/30/21.
//

import CoreLocation
import Foundation
import SwiftUI
import Combine

public class RestaurantFetcher: ObservableObject {
	@Published var restaurantWithMenu = [DocuMenuRestaurant]()
	@ObservedObject var locationManager = LocationManager()
	@Published var isLoadingPage = false
	private var currentPage = 1
	private var canLoadMorePages = true

	func loadMoreRestaurantIfNeeded(currentRestaurant: DocuMenuRestaurant?) {
		guard (currentRestaurant != nil) else {
			loadDocuMenu(latitude: locationManager.lastLocation.latitude, longitude: locationManager.lastLocation.longitude, distance: 5)
			return
		}
		if restaurantWithMenu.count < 5 {
			loadDocuMenu(latitude: locationManager.lastLocation.latitude, longitude: locationManager.lastLocation.longitude, distance: 5)
		}
	}

	func loadDocuMenu(latitude: Double, longitude: Double, distance: Int){
		guard !self.isLoadingPage && self.canLoadMorePages else {
			return
		}
		self.isLoadingPage = true
		let headers = [
			"x-api-key": "7b221218fcc362fbc5de096aa4386cbc",
			"x-rapidapi-host": "documenu.p.rapidapi.com",
			"x-rapidapi-key": "92a76aa3f4msh69933f14b31c7d4p108ed8jsnf6c71a5f5108"
		]
		let urlString = "https://documenu.p.rapidapi.com/restaurants/search/geo?lat=\(latitude)&lon=\(longitude)&distance=\(distance)&page=\(currentPage)&fullmenu=true"
		let url = URL(string: urlString)!
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.allHTTPHeaderFields = headers

		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		URLSession.shared.dataTaskPublisher(for: request)
			.map(\.data)
			.decode(type: DocuMenuResponse.self, decoder: decoder)
			.receive(on: DispatchQueue.main)
			.handleEvents(receiveOutput: {response in
				self.canLoadMorePages = response.morePages
				self.isLoadingPage = false
				self.currentPage += 1
			})
			.map({ response in
				return self.restaurantWithMenu + response.restaurants.shuffled()
			})
			.catch({_ in Just(self.restaurantWithMenu)})
			.assign(to: &$restaurantWithMenu)
	}
}
