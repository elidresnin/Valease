//
//  HomeView.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/19/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var user: User
    @EnvironmentObject var allTrips: Trips
    
    var body: some View {
        
        NavigationView {
            VStack{
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 200))
                    .foregroundColor(Color.valeaseGreen)
                Text("My trips")
                    .fontWeight(.bold)
                    .font(.title)
                
                Spacer()
                
                List(allTrips.tripList) { trip in
                    NavigationLink{
                        TripView(trip: trip)
                    } label: {
                        Text(trip.name)
                    }
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack{
                        Image(systemName: "plus.circle")
                            .foregroundColor(.valeaseTeal)
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                        Text("Add Trip")
                            .font(.system(size: 20))
                            .foregroundColor(.valeaseTeal)
                            .fontWeight(.bold)
                    }
                }

            }
            
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(User())
            .environmentObject(Trips())
    }
}
