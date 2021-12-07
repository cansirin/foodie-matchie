//
//  RestaurantFetcher.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 11/30/21.
//

import CoreLocation
import Foundation
import SwiftUI

public class RestaurantFetcher: ObservableObject {
	@Published var restaurants = [Restaurant]()
	@Published var restaurantWithMenu = [DocuMenuRestaurant]()
	var offset = 1
	var limit = 50

	func loadYelpAPI(latitude: Double, longitude: Double){
		let apiKey = "Ib4kP9Ch99mkkO70e-YkIR_llFyCo7QENlfGwE0ob6Yr0kAl_uSpSh5iinPcTtroLVd5Ira9nWg-EBVeTjjefS14Y9iYoWTrUsVX5-OFz8VW8zwCW62uqWAnV9iEYXYx"
		let url = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)&radius=40000&offset=\(offset)&limit=\(limit)")!
		var request = URLRequest(url: url)
		request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
		request.httpMethod = "GET"

		URLSession.shared.dataTask(with: request) { (data, response, error) in
			do {
				if let d = data {
					let decoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase
					let decodedLists = try decoder.decode(RestaurantResponse.self, from: d)
					DispatchQueue.main.async {
						self.restaurants = decodedLists.restaurants
					}
				} else {
					print("No data")
				}
			} catch {
				print("Unexpected Error: \(error)")
			}
		}.resume()
	}

	func loadDocuMenu(latitude: Double, longitude: Double, distance: Int){
		let headers = [
			"x-api-key": "e529f442ec7db3ace50cfff0df7d5332",
			"x-rapidapi-host": "documenu.p.rapidapi.com",
			"x-rapidapi-key": "92a76aa3f4msh69933f14b31c7d4p108ed8jsnf6c71a5f5108"
		]
		print(latitude, longitude, distance)
		let originalString = "https://documenu.p.rapidapi.com/restaurants/search/geo?lat=\(latitude)&lon=\(longitude)&distance=\(distance)&fullmenu=true"
		guard let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
		let url = URL(string: urlString)!

		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.allHTTPHeaderFields = headers

		URLSession.shared.dataTask(with: request) { (data, response, error) in
			do {
				if let d = data {
					let decoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase
					let decodedLists = try decoder.decode(DocuMenuResponse.self, from: d)
					DispatchQueue.main.async {
						self.restaurantWithMenu = decodedLists.restaurants
					}
				} else {
					print("No data")
				}
			} catch {
				print("Unexpected Error: \(error)")
			}
		}.resume()
	}
}
