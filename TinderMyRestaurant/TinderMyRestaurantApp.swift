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
	@StateObject private var persistenceController = PersistenceController()

	init() {
		FirebaseApp.configure()
	}

	var body: some Scene {
		WindowGroup {
			ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
		}
	}
}

