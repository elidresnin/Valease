//
//  FlightView.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 3/21/24.
//

import SwiftUI

extension Data: Identifiable {
    
}

struct FlightView: View {
    @EnvironmentObject var flightsResult: FlightData
    @Binding var currentTrip: Trip
    
    var body: some View {
        //NavigationView{
        VStack{
            Text(flightsResult.fly_to)
            List(flightsResult.results){ flight in
                NavigationLink (destination: {
                    FlightDetailView(currentTrip:  $currentTrip, flight: flight)
                }, label: {
                    VStack{
                        HStack{
                            Spacer()
                            AsyncImage(
                                url: URL(string: flight.logoURL),
                                content: { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 150, maxHeight: 75)
                                },
                                placeholder: {
                                    ProgressView()
                                        .frame(maxWidth: 150, maxHeight: 75)
                                }
                            )
                            
                            Spacer()
                            Text("\(flight.airline) \(String(flight.flightNumber))")
                            Spacer()
                        }
                        HStack{
                            
                            
                            //                                Text(flight.departureDate.formatted(date: .numeric, time: .shortened) ?? "err")
                            //
                            //
                            //                                Text(flight.arrivalDate.formatted(date: .numeric, time: .shortened) ?? "err")
                            Text("\(flight.departure) - \(flight.arrival)")
                            Spacer()
                            Text("$\(flight.price)")
                        }
                    }
                    .padding()
                    
                })
            }
            .task {
                if (flightsResult.fly_from != "" && flightsResult.fly_to != ""){
                    await flightsResult.loadData()
                    
                }
                
            }
            
        }
        //}
    }
}
struct FlightView_Previews: PreviewProvider {
    static var previews: some View {
        FlightView(currentTrip: Binding.constant(Trip()))
            .environmentObject(FlightData())
        
    }
}
