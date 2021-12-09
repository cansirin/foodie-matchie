//
//  Restaurants.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 11/30/21.
//

import SwiftUI
import FirebaseFirestore

struct Restaurants: View {
	@ObservedObject var fetcher: RestaurantFetcher
	@ObservedObject var session: SessionStore
	@ObservedObject var locationManager: LocationManager
	@State private var selection: Int? = nil
	@GestureState var translation: CGSize = .zero
	
	func removeRestaurant(restaurant: DocuMenuRestaurant) {
		fetcher.restaurantWithMenu = fetcher.restaurantWithMenu.filter { resta in
			resta.restaurantName != restaurant.restaurantName
		}
	}
	
	func saveLikedRestaurants(restaurantName: String) {
		let data = ["name": restaurantName]
		if(session.session != nil){
			let docRef = Firestore.firestore().document("likes/\(session.session?.uid ?? "empty")/restaurants/\(restaurantName)")
			print("setting data")
			docRef.setData(data) { (error) in
				if let error = error {
					print("error: \(error)")
				} else {
					print("data uploaded successfully")
				}
			}
		} else {
			return
		}
	}
	
	
	var body: some View {
		let dragGesture = DragGesture().updating($translation) { value, state, _ in
			state = value.translation
		}
		VStack {
			Spacer()
				.frame(height: 50)
			TopView(session: session, fetcher: fetcher, locationManager: locationManager)
			NavigationView {
				VStack{
					GeometryReader { geometry in
						if(!fetcher.isLoadingPage){
							ForEach(fetcher.restaurantWithMenu.indices, id: \.self) { index in
								let restaurant = fetcher.restaurantWithMenu[index]
								VStack {
									RestaurantCard(restaurant: restaurant, locationManager: locationManager)
										.onDisappear() {
											fetcher.loadMoreRestaurantIfNeeded(currentRestaurant: restaurant)
										}
										.animation(.interactiveSpring())
										.offset(x: self.translation.width, y: 0)
										.rotationEffect(.degrees(Double(self.translation.width / geometry.size.width)*25), anchor: .bottom)
										.gesture(dragGesture.onEnded({ value in
											let direction = detectDirection(value: value)
											if(direction == .left){
												removeRestaurant(restaurant: restaurant)
											}
											if(direction == .right){
												self.selection = restaurant.restaurantId
												saveLikedRestaurants(restaurantName: restaurant.restaurantName)
											}
										}))
									NavigationLink(destination: SingleRestaurant(locationManager: locationManager, restaurant: restaurant), tag: restaurant.restaurantId, selection: $selection) {	HStack {
										Button {
											self.selection = nil
											removeRestaurant(restaurant: restaurant)
										} label: {
											Image(systemName: "xmark.circle").foregroundColor(.red).font(.system(size: 64))
										}
										Button {
											saveLikedRestaurants(restaurantName: restaurant.restaurantName)
											self.selection = restaurant.restaurantId
										} label: {
											Image(systemName: "heart.circle").foregroundColor(.green).font(.system(size: 64))
										}
									}
									}.padding(.bottom, 15)
								}.background(LinearGradient(gradient: Gradient(colors: [Color(ColorCodes().fv), Color(ColorCodes().pur)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
								)
							}
						} else {
							ActivityIndicator()
								.foregroundColor(.green)
						}
					}
				}.navigationBarHidden(true)
					.navigationBarTitle("Restaurants")
					.navigationViewStyle(StackNavigationViewStyle())
					.statusBar(hidden: true)
			}
		}
		.background(Color(ColorCodes().fv)).ignoresSafeArea()
	}
}

struct LikeAndDislikeButtons: View {
	var body: some View {
		HStack {
			Button {
				print("Edit button was tapped")
			} label: {
				Image(systemName: "xmark.circle").foregroundColor(.red).font(.system(size: 52))
			}
			Button {
				print("Edit button was tapped")
			} label: {
				Image(systemName: "heart.circle").foregroundColor(.green).font(.system(size: 52))
			}
			
		}
		.padding(.top)
	}
}

struct Restaurants_Previews: PreviewProvider {
	static var previews: some View {
		Restaurants(fetcher: RestaurantFetcher(), session: SessionStore(), locationManager: LocationManager())
	}
}
