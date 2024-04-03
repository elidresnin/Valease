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
    @State var flightsResult: FlightData
    var body: some View {
        VStack{
            Text(flightsResult.fly_to)
            List(flightsResult.results){ flight in
                VStack{
                    Text("\(flight.airline) \(String(flight.flightNumber))")
                        
                        
                }
            }
            .task {
                await flightsResult.loadData()
                print("dtat")
            }
            
        }
    }
}
struct FlightView_Previews: PreviewProvider {
    static var previews: some View {
        FlightView(flightsResult: FlightData())

    }
}
