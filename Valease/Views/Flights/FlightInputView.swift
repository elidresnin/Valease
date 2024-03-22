//
//  FlightInputView.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 3/21/24.
//

import SwiftUI

struct FlightInputView: View {
    @EnvironmentObject var flights: Flights
    var body: some View {
        VStack{
            Spacer()
            Text("Enter Flight Informantion")
                .font(Constants.mediumFont)
            Spacer()
            TextField("To", text: $flights.to)
                .padding()
                .multilineTextAlignment(.center)
                .font(Constants.mediumFont)
                .border(Color.valeaseOrange, width: 4)
                .padding()
            Spacer()
            TextField("From", text: $flights.from)
                .padding()
                .multilineTextAlignment(.center)
                .font(Constants.mediumFont)
                .border(Color.valeaseOrange, width: 4)
                .padding()
            Spacer()
            TextField("Departure Date", text: $flights.departureDate)
                .padding()
                .multilineTextAlignment(.center)
                .font(Constants.mediumFont)
                .border(Color.valeaseOrange, width: 4)
                .padding()
            Spacer()
            NavigationLink(destination: {
                FlightView(flights: flights)
            }, label: {
                Text("Search")
                    .font(Constants.mediumFont)
                    .foregroundColor(Color.textColor)
                    .padding(.horizontal, 114)
                    .padding(.vertical, 10)
                    .background(Color.valeaseTeal)
                    .cornerRadius(20)
            })
            .padding()
            
        }
    }
}

struct FlightInputView_Previews: PreviewProvider {
    static var previews: some View {
        FlightInputView()
            .environmentObject(Flights())
    }
}
