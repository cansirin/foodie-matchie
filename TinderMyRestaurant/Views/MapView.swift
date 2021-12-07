//
//  MapView.swift
//  TinderMyRestaurant
//
//  Created by Xinrong Wen on 12/6/21.
//

import SwiftUI
import MapKit

struct MapView: View{
	@ObservedObject private var locationManager = LocationManager()
	private var annotation: [AnnotationItem] = []
//	@State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.latitude, longitude: -121.891054), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))

	init(latitude: Double, longitude: Double) {
		self.annotation.append(AnnotationItem(coordinate: CLLocationCoordinate2D(
			latitude: latitude,
			longitude: longitude)))
	}

    var body: some View{
			Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: annotation) { item in
				MapMarker(coordinate: item.coordinate)
			}
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
			MapView(latitude: 37.93, longitude: -122.334)
    }
}

struct AnnotationItem: Identifiable {
	var coordinate: CLLocationCoordinate2D
	let id = UUID()
	let color = Color.purple
}
