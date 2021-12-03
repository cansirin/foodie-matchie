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
	var price: String
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
	}
	var restaurants: [Restaurant]
}

// DocuMenu API Types
struct DocuMenuResponse: Codable {
	enum CodingKeys: String, CodingKey {
		case restaurant = "data"
	}

	var restaurant: [DocuMenuRestaurant]
}


struct DocuMenuRestaurant: Hashable, Codable {
	var restaurantName: String
	var restaurantPhone: String
	var hours: String
	var priceRange: String
	var	address: Address
	var cuisines: [String]
	var menus: [MenuSections]
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
