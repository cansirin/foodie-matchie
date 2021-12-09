//
//  types.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 11/30/21.
//

import Foundation


// Yelp API Types
struct Restaurant: Hashable, Codable {
	var id: String
	var name: String
	var isClosed: Bool
	var imageUrl: String
	var url: String?
	var rating: Double
	var displayPhone: String
	var distance: Double
	var location: Location
	var price: String?
}

struct Location: Codable, Hashable {
	var city: String?
	var country: String?
	var state: String?
	var address1: String?
	var zip_code: String?
//	var coordinates: [String]
}

struct RestaurantResponse: Codable {
	enum CodingKeys: String, CodingKey {
		case restaurants = "businesses"
		case total
	}
	var total = 0
	var restaurants: [Restaurant]
}

// DocuMenu API Types
struct DocuMenuResponse: Codable {
	enum CodingKeys: String, CodingKey {
		case restaurants = "data"
		case morePages
	}
	var morePages: Bool
	var restaurants: [DocuMenuRestaurant]
}


struct DocuMenuRestaurant: Hashable, Codable {
	var restaurantId: Int
	var restaurantName: String
	var restaurantPhone: String
	var restaurantWebsite: String
	var priceRangeNum: Int
	var	address: Address
	var cuisines: [String]
	var menus: [MenuSections]
	var geo: Coordinate
}

struct Coordinate: Hashable, Codable {
	var lat: Double
	var lon: Double
}

struct Address: Codable, Hashable {
	var city: String
	var state: String
	var postalCode: String
	var street: String
	var formatted: String
}

struct MenuSections: Hashable, Codable {
	var menuSections: [MenuSection]
}

struct MenuSection: Hashable, Codable {
	var sectionName: String
	var menuItems: [MenuItem]
}

struct MenuItem: Hashable, Codable {
	var name: String
	var description: String
	var price: Double
}
