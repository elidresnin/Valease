//
//  FlightInputView.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 3/21/24.
//

import SwiftUI

struct FlightInputView: View {
    @EnvironmentObject var flights: FlightData
    @Binding var currentTrip: Trip
    @State var to: String = ""
    @State var from: String = ""
    @State var date: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                Text("Enter Flight Informantion")
                    .font(Constants.mediumFont)
                Spacer()
                TextField("To", text: $flights.fly_to)
                    .autocapitalization(UITextAutocapitalizationType.allCharacters)
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(Constants.mediumFont)
                    .border(Color.valeaseOrange, width: 4)
                    .padding()
                Spacer()
                TextField("From", text: $flights.fly_from)
                    .autocapitalization(UITextAutocapitalizationType.allCharacters)
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(Constants.mediumFont)
                    .border(Color.valeaseOrange, width: 4)
                    .padding()
                Spacer()
                DatePicker("Select a Date",
                           selection: $flights.date_to,
                                       displayedComponents: .date)
                .padding()
                .multilineTextAlignment(.center)
                .font(Constants.mediumFont)
                .border(Color.valeaseOrange, width: 4)
                .padding()
                Spacer()
                if (flights.fly_from != "" && flights.fly_to != ""){
                    
                    NavigationLink(destination: FlightView(currentTrip: $currentTrip)
                        .task {
                            await flights.loadData()
                        }
                    ) {
                        Text("Search")
                            .font(Constants.mediumFont)
                            .foregroundColor(Color.textColor)
                            .padding(.horizontal, 114)
                            .padding(.vertical, 10)
                            .background(Color.valeaseTeal)
                            .cornerRadius(20)
                    }
                    
                } else {
                    
                }
                
                
            }
       }
    }
}

struct FlightInputView_Previews: PreviewProvider {
    static var previews: some View {
        FlightInputView(currentTrip: Binding.constant(Trip()))
            .environmentObject(FlightData())
    }
}
