//
//  LocationRequestView.swift
//  RateMyRestaurant
//
//  Created by Can Sirin on 11/4/21.
//

import SwiftUI

struct LocationRequestView: View {
	@ObservedObject var locationManager: LocationManager
	
	var body: some View {
		VStack {
			Image(systemName: "location.circle").resizable().frame(width: 100, height: 100, alignment: .center).foregroundColor(.blue)
			Button(action: {
				locationManager.requestPermission()
			}, label: {
				Label("Allow tracking", systemImage: "location.circle")
			}).padding(10).foregroundColor(.white).background(Color.blue).clipShape(RoundedRectangle(cornerRadius: 8))
			Text("We need your permission to track your location").foregroundColor(.gray).font(.caption)
		}
	}
}

//struct LocationRequestView_Previews: PreviewProvider {
//	static var previews: some View {
//		LocationRequestView()
//	}
//}
