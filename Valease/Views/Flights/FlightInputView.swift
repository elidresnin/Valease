//
//  FlightInputView.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 3/21/24.
//

import SwiftUI

struct FlightInputView: View {
    @EnvironmentObject var flights: FlightData
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                Text("Enter Flight Informantion")
                    .font(Constants.mediumFont)
                Spacer()
                TextField("To", text: $flights.fly_to)
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(Constants.mediumFont)
                    .border(Color.valeaseOrange, width: 4)
                    .padding()
                Spacer()
                TextField("From", text: $flights.fly_from)
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(Constants.mediumFont)
                    .border(Color.valeaseOrange, width: 4)
                    .padding()
                Spacer()
                TextField("Departure Date", text: $flights.date_to)
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(Constants.mediumFont)
                    .border(Color.valeaseOrange, width: 4)
                    .padding()
                Spacer()
                
                NavigationLink {
                    FlightView(flightsResult: flights)
                    
                } label: {
                    Text("search")
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

struct FlightInputView_Previews: PreviewProvider {
    static var previews: some View {
        FlightInputView()
            .environmentObject(FlightData())
    }
}
