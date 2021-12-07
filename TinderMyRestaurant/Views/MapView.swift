//
//  MapView.swift
//  TinderMyRestaurant
//
//  Created by Xinrong Wen on 12/6/21.
//

import SwiftUI
import MapKit

struct MapView: View{

    
@State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
    var body: some View{
        Map(coordinateRegion: $region, showsUserLocation: true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
