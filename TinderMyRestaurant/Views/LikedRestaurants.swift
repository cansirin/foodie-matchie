//
//  LikedRestaurants.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 12/8/21.
//

import SwiftUI
import FirebaseFirestore

struct LikedRestaurant: Identifiable {
	var id = UUID()
	var restaurantName: String
}

struct LikedRestaurants: View {
	@ObservedObject var session: SessionStore
	@State var likedRestaurants: [LikedRestaurant] = []
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

	func deleteRestaurantLikes() {
		Firestore.firestore().collection("likes").document("\(session.session?.uid ?? "")").collection("restaurants").getDocuments() { (querySnapshot, err) in
			if let err = err {
				print("Error getting documents: \(err)")
			} else {
				for document in querySnapshot!.documents {
					print("\(document.documentID) => \(document.data())")
					document.reference.delete()
				}
			}

		}
	}

	func getLikedRestaurants() {
		Firestore.firestore().collection("likes").document("\(session.session?.uid ?? "")").collection("restaurants")
			.addSnapshotListener { querySnapshot, error in
				guard let documents = querySnapshot?.documents else {
					print("Error fetching documents: \(error)")
					return
				}
				let userLikes = documents.map { $0["name"] }
				for i in 0..<userLikes.count {
					likedRestaurants.append(LikedRestaurant(restaurantName: userLikes[i] as! String))
				}
			}
	}

	var body: some View {
		VStack{
			Button(action:{deleteRestaurantLikes()
				self.presentationMode.wrappedValue.dismiss()
			}) {
				Text("Remove all").foregroundColor(.white)
			}

			List{
				ForEach(likedRestaurants) { like in
					Text(like.restaurantName).foregroundColor(Color(ColorCodes().pur))
				}
			}
		}
		.onAppear(perform: {
			getLikedRestaurants()
		})
		.background(
			LinearGradient(gradient: Gradient(colors: [Color(ColorCodes().fv), Color(ColorCodes().pur)]), startPoint: .top, endPoint: .bottom)
				.edgesIgnoringSafeArea(.all))
	}

}

struct LikedRestaurants_Previews: PreviewProvider {
	static var previews: some View {
		LikedRestaurants(session: SessionStore())
	}
}
