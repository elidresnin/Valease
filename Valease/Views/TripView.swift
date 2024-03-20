//
//  TripView.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/14/24.
//

import SwiftUI

struct TripView: View {
    @State var trip: Trip
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: {
                    PackingView()
                }, label: {
                    VStack{
                        HStack {
                            Text("Packing List")
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .foregroundColor(Color.valeaseOrange)
                            Spacer()
                        }
                        Image("packing")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                    }
                })
                
                Spacer()
                
                NavigationLink{
                    ItineraryView()
                } label: {
                    VStack{
                        HStack {
                            Text("Itinerary")
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                            .foregroundColor(Color.valeaseOrange)
                            Spacer()
                        }
                        Image("plan")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                    }
                }
            }.navigationTitle(trip.name)
                .padding()
        }

    }
}

struct TripView_Previews: PreviewProvider {
    static var previews: some View {
        TripView(trip: Trip())
            .environmentObject(Trips())
    }
}
