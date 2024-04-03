//
//  FlightInputView.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 3/21/24.
//

import SwiftUI

struct FlightInputView: View {
    @EnvironmentObject var flights: FlightData
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
                TextField("To", text: $to)
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(Constants.mediumFont)
                    .border(Color.valeaseOrange, width: 4)
                    .padding()
                Spacer()
                TextField("From", text: $from)
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(Constants.mediumFont)
                    .border(Color.valeaseOrange, width: 4)
                    .padding()
                Spacer()
                TextField("Departure Date", text: $date)
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(Constants.mediumFont)
                    .border(Color.valeaseOrange, width: 4)
                    .padding()
                Spacer()
                if (from != "" && to != "" && date != ""){
                    NavigationLink {
                        
                        FlightView(flightsResult: FlightData(fly_from: from, fly_to: to, date_from: date, date_to: date))
                    } label: {
                        Text("search")
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
        FlightInputView()
            .environmentObject(FlightData())
    }
}
