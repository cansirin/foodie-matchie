//
//  TinderMyRestaurantApp.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 11/30/21.
//

import SwiftUI
import Firebase
import CoreData

@main
struct TinderMyRestaurantApp: App {
	init() {
		FirebaseApp.configure()
	}
	
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}

