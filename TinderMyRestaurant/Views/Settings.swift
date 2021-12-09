//
//  Settings.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 12/1/21.
//

import SwiftUI

struct Settings: View {
    @ObservedObject var sessionStore: SessionStore
    @ObservedObject var fetcher: RestaurantFetcher
        @ObservedObject var locationManager: LocationManager
    @State var sliderValue: Double = 0
    
    var body: some View {
        VStack{
            Spacer()
                .frame(height: 80)
            Section(header: Text("Account").font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)){
                Image(systemName: "person").resizable().frame(width: 50, height: 50)
                Text("Profile Setting").font(.largeTitle)
            }.foregroundColor(.white).frame(width: 300)
            .padding(3)
            
            VStack(){
                Slider(value: $sliderValue, in: 0...20).accentColor(Color(.white)).background(Color(ColorCodes().indigo)).cornerRadius(30)
                Text("Current distance from you: \(Int(sliderValue))").fontWeight(.heavy)
                
            }.padding()
            .foregroundColor(Color(.white))
            
            VStack{
                Button("Save this distance", action: {fetcher.loadDocuMenu(latitude: locationManager.lastLocation.latitude, longitude: locationManager.lastLocation.longitude, distance: Int(sliderValue))}
                ).foregroundColor(Color.white)
            }.padding(10)
            .background(Color(ColorCodes().indigo))
            .cornerRadius(50).padding()
            Spacer()
            HStack{
                Section(){
                Button("Sign out", action: {
                    sessionStore.signOut()
                }).padding()
                    .font(.largeTitle)
                    .frame(alignment: .center)
                    .foregroundColor(Color.white)
            }.frame( alignment: .center)
                .background(Color(ColorCodes().indigo))
                .cornerRadius(30.0)
            }
            Spacer()
            
        }
        .background(Color(ColorCodes().fv)).ignoresSafeArea()
    }
}
                     
                     
                     struct Settings_Previews: PreviewProvider {
                    static var previews: some View {
                        Settings(sessionStore: SessionStore(), fetcher: RestaurantFetcher(), locationManager: LocationManager())
                    }
                }
