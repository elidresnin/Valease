//
//  FlightDetailView.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 3/21/24.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseStorage
import FirebaseDatabase

struct FlightDetailView: View {
    @EnvironmentObject var flights: FlightData
    @EnvironmentObject var events : Events
    @State var flight: Flight
    
    
    var body: some View {
        var flightData = ["airline" : flight.airlineName,
                          "flight number" : String(flight.flightNumber),
                          "price" : String(flight.price),
                          "link" : flight.deepLink,
                          "departure" : flight.departure,
                          "arrival" : flight.arrival
        ]
        
        HStack{
            VStack{
                Spacer()
                AsyncImage(
                    url: URL(string: flight.logoURL),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 300, maxHeight: 150)
                    },
                    placeholder: {
                        ProgressView()
                            .frame(maxWidth: 300, maxHeight: 150)
                        
                    }
                )
                Spacer()
                Text("\(flight.airline) \(String(flight.flightNumber))")
                
                
                Text("\(flight.departure)")
                Text("\(flight.arrival)")
                
                Text("$\(flight.price)")
                Spacer()
                
                
                
                Button {
                    
                    let dateFormatter = ISO8601DateFormatter()
                    dateFormatter.formatOptions = [.withFullDate] // Added format options
                    let leaveDate = dateFormatter.date(from: flight.departure) ?? Date.now
                    
                    guard let uid = Auth.auth().currentUser?.uid else {return}
                    Database.database().reference().child("users/\(uid)/flightData/\(flight.id)").setValue(flightData)
                    
                    let newFlight = Event(name: flight.airlineName, location: String(flight.flightNumber), date: leaveDate, time: String(flight.price))
                    
                    events.eventList.append(newFlight)
                    
                    
                } label: {
                    Text("[Book](\(flight.deepLink))")
                        .font(Constants.mediumFont)
                        .foregroundColor(Color.textColor)
                        .padding(.horizontal, 114)
                        .padding(.vertical, 10)
                        .background(Color.valeaseTeal)
                        .cornerRadius(20)
                }
                
            }
            
        }
    }
}

struct FlightDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FlightDetailView(flight: Flight())
            .environmentObject(FlightData())
            .environmentObject(Events())
    }
}
