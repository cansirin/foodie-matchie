//
//  ErrorView.swift
//  RateMyRestaurant
//
//  Created by Can Sirin on 11/4/21.
//

import SwiftUI

struct ErrorView: View {
	var errorText: String

	var body: some View {
		VStack{
			Image(systemName: "xmark.octagon").resizable().frame(width: 100, height: 100, alignment: .center)
			Text(errorText)
//            Text(self.error = "RESET" ? "Password reset link has been sent to your email" : self.error)
		}.padding().foregroundColor(.white).background(Color.red)
        
	}
}

struct ErrorView_Previews: PreviewProvider {
	static var previews: some View {
		ErrorView(errorText: "Location use is restricted")
	}
}
