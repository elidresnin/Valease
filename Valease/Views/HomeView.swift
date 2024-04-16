//
//  HomeView.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/19/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct HomeView: View {
    @EnvironmentObject var user: User
    @EnvironmentObject var allTrips: Trips
    @State var showSheet = false
    
    
    func saveTrip(name: String, location: String, id: UUID) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let tripObject = [
                    "name" : name,
                    "location" : location,
                    "id" : id.uuidString
                ] as [String: Any]
        
        let databaseRef = Database.database().reference().child("users/\(uid)/trips/\(id)")
        
        databaseRef.setValue(tripObject)

    }
    
    func addTrip(trip: Trip) {
        allTrips.tripList.append(trip)
        showSheet.toggle()
        saveTrip(name: trip.name, location: trip.location, id: trip.id)
    }
    
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
                    ForEach($allTrips.tripList) { $trip in
                        NavigationLink(destination: TripView(currentTrip: $trip)) {
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
            TripDetailView(isSheetPresented: .constant(false), trip: Trip(), addTrip: { trip in
                self.addTrip(trip: trip)
            })
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
                .environmentObject(User())
                .environmentObject(Trips())
                .environmentObject(Items())
                .environmentObject(Events())
        }
    }
}
