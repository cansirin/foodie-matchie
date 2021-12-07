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
    @State var sliderValue: Double = 0
    
    var body: some View {
        List {
            Section(header: Text("Account")){
                
                Image(systemName: "person").resizable().frame(width: 50, height: 50)
                Text("Profile Setting").font(.largeTitle)
            }.foregroundColor(.gray).frame(width: 300)
            
            
            VStack(){
                Slider(value: $sliderValue, in: 0...20).accentColor(Color.yellow)
                Text("Current distance from you: \(sliderValue, specifier: "%.2f")")
                
            }.padding()
                .foregroundColor(Color.green)
            
            Button("Save this distance", action: {fetcher.loadDocuMenu(address: "59 FBI Street")} )
            Section(){
                Button("Sign out", action: {
                    sessionStore.signOut()
                }).padding()
                    .font(.largeTitle)
                    .frame(alignment: .center)
            }.padding()
                .frame(alignment: .center)
                
            
        }
    }
}



struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(sessionStore: SessionStore(), fetcher: RestaurantFetcher())
    }
}
