//
//  FlightDetailView.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 3/21/24.
//

import SwiftUI




struct FlightDetailView: View {
    @EnvironmentObject var flights: FlightData
    @State var flight: Flight
    var body: some View {
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
    }
}
