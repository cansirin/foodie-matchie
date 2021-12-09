//
//  LikedRestaurants.swift
//  TinderMyRestaurant
//
//  Created by Can Sirin on 12/8/21.
//

import SwiftUI

struct LikedRestaurants: View {
    @FetchRequest(entity: RestaurantLike.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \RestaurantLike.restaurantName, ascending: true)]) var likes: FetchedResults<RestaurantLike>
    @Environment(\.managedObjectContext) var moc
    
    func deleteRestaurantLikes() {
        for like in likes {
            moc.delete(like)
        }
        try? moc.save()
    }
    
    private func deleteRestaurantLike(offsets: IndexSet) {
        offsets.map { likes[$0] }.forEach(moc.delete)
        
        do {
            try moc.save()
        } catch {
            // Error handling
        }
    }
    
    var body: some View {
        VStack{
            Button(action:{deleteRestaurantLikes()}) {
                Text("Remove all").foregroundColor(.white)
            }
            
            List{
                ForEach(likes) { like in
                    Text(like.restaurantName ?? "Unknown").foregroundColor(Color(ColorCodes().pur))
                }
                .onDelete(perform: deleteRestaurantLike)
            }
        }.background(
            LinearGradient(gradient: Gradient(colors: [Color(ColorCodes().fv), Color(ColorCodes().pur)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
    }
    
}

struct LikedRestaurants_Previews: PreviewProvider {
    static var previews: some View {
        LikedRestaurants()
    }
}
