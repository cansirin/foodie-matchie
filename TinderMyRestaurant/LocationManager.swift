//
//  LocationManager.swift
//  RateMyRestaurant
//
//  Created by Can Sirin on 11/3/21.
//

import Foundation
import CoreLocation
import Combine
import MapKit


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
	private let locationManager: CLLocationManager
	@Published var authStatus: CLAuthorizationStatus?
	@Published var lastLocation: CLLocation
	@Published var currentPlacemark: CLPlacemark?
	@Published var region = MKCoordinateRegion()

	override init() {
		self.locationManager = CLLocationManager()
		self.lastLocation = CLLocation(latitude: 0, longitude: 0)
		super.init()
		self.locationManager.delegate = self
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
		self.locationManager.startUpdatingLocation()
	}

	func requestPermission() {
		locationManager.requestWhenInUseAuthorization()
	}

	var statusString: String {
		guard let auth = authStatus else {
			return "unknown"
		}

		switch auth {
			case .notDetermined:
				return "not determined"
			case .authorizedWhenInUse:
				return "authorized when in use"
			case .authorizedAlways:
				return "authorized always"
			case .restricted:
				return "restricted"
			case .denied:
				return "denied"
			default:
				return "unknown"
		}
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let currentLocation = locations.last else {return}
		self.lastLocation = currentLocation
		fetchCityAndCountry(for: self.lastLocation)
		locations.last.map {
			let center = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
			let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
			region = MKCoordinateRegion(center: center, span: span)
		}
	}

	func fetchCityAndCountry(for location: CLLocation?) {
		guard let location = location else { return }
		let geocoder = CLGeocoder()
		geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
			self.currentPlacemark = placemarks?.first
		}
	}

	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		authStatus = manager.authorizationStatus
		print("[auth status]:", statusString )
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("LocationManager error: ",error)
	}
}

extension CLLocation {
	var latitude: Double {
		return self.coordinate.latitude
	}
	var longitude: Double {
		return self.coordinate.longitude
	}
}
