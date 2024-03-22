//
//  FlightView.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 3/21/24.
//

import SwiftUI

struct FlightView: View {
    var flights: Flights
    
    var body: some View {
        VStack{
            List(flights.results) {flight in
                HStack{
                    Text(flight.airline)
                        .task {
                           await flights.fetchData()
                        }
                      
                }
            }
            
        }
    }
}
struct FlightView_Previews: PreviewProvider {
    static var previews: some View {
        FlightView(flights: Flights())
            
    }
}
