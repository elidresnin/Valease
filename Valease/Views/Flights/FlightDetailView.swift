//
//  FlightDetailView.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 3/21/24.
//

import SwiftUI

struct FlightDetailView: View {
    @EnvironmentObject var flights: Flights
    var body: some View {
        HStack{
           
            
        }
    }
}

struct FlightDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FlightDetailView()
            .environmentObject(Flights())
    }
}
