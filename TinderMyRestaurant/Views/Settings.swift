//
//  Settings.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 12/1/21.
//

import SwiftUI

struct Settings: View {
    @ObservedObject var sessionStore: SessionStore
    
    var body: some View {
        List {
            Section(header: Text("Account")){
                
                Image(systemName: "person").resizable().frame(width: 50, height: 50)
                Text("Profile Setting").font(.largeTitle)
            }.foregroundColor(.gray).frame(width: 300)
            
            
            VStack(){
                Text("Placeholder for future feature")
                Text("Placeholder for future feature")
            }
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
        Settings(sessionStore: SessionStore())
    }
}
