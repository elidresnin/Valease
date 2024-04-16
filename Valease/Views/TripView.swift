//
//  TripView.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/14/24.
//

import SwiftUI

struct TripView: View {
    @Binding var currentTrip: Trip
    
    var body: some View {
        //NavigationView{
            VStack{
                NavigationLink(destination: {
                    PackingView(currentTrip: $currentTrip)
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
                
//                Spacer()
                
                NavigationLink{
                    ItineraryView(currentTrip: $currentTrip)
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
            }.navigationTitle(currentTrip.name)
                .padding()
        //}

    }
}

struct TripView_Previews: PreviewProvider {
    static var previews: some View {
        TripView(currentTrip: Binding.constant(Trip()))
            .environmentObject(Trips())
    }
}
