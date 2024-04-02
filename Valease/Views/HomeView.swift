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
    @State var showSheet = false
    
//    func addTrip(trip: Trip) {
//        allTrips.tripList.append(trip)
//        showSheet = false
//    }
    
    func deleteTrip(at offsets: IndexSet) {
        allTrips.tripList.remove(atOffsets: offsets)
    }
    
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
                
                List {
                    ForEach(allTrips.tripList) { trip in
                        NavigationLink(destination: TripView(trip: trip)) {
                            Text(trip.name)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .border(Color.valeaseTeal, width: 4)
                        }
                    }
                    .onDelete(perform: deleteTrip)
                }.listStyle(PlainListStyle())
                
                
                Spacer()
                
                Button {
                    showSheet.toggle()
                } label: {
                    HStack{
                        Image(systemName: "plus.circle")
                            .foregroundColor(.valeaseOrange)
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                        Text("Add Trip")
                            .font(.system(size: 20))
                            .foregroundColor(.valeaseOrange)
                            .fontWeight(.bold)
                    }
                }
                
            }
            
        }.sheet(isPresented: $showSheet) {
            TripDetailView(isSheetPresented: $showSheet)
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
                .environmentObject(User())
                .environmentObject(Trips())
        }
    }
}
