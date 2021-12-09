//
//  PersistenceController.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 12/8/21.
//

import Foundation
import CoreData

class PersistenceController: ObservableObject {
	// A singleton for our entire app to use
	static let shared = PersistenceController()

	// Storage for Core Data
	let container: NSPersistentContainer

	// A test configuration for SwiftUI previews
	// An initializer to load Core Data, optionally able
	// to use an in-memory store.
	init() {
		// If you didn't name your model Main you'll need
		// to change this name below.
		container = NSPersistentContainer(name: "FoodieMatchieApp")


		container.loadPersistentStores { description, error in
			if let error = error {
				fatalError("Error: \(error.localizedDescription)")
			}
		}
	}

	func save() {
		let context = container.viewContext

		if context.hasChanges {
			do {
				try context.save()
			} catch {
				// Show some error here
			}
		}
	}
}
