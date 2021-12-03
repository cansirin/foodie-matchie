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
			Button(action: {
				sessionStore.signOut()
			}) {
				Image(systemName: "gearshape").resizable().frame(width: 35, height: 35)
			}.foregroundColor(.gray)
		}
	}
}



struct Settings_Previews: PreviewProvider {
	static var previews: some View {
		Settings(sessionStore: SessionStore())
	}
}
