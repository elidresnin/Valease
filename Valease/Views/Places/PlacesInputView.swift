//
//  PlacesInputView.swift
//  Valease
//
//  Created by Bole Ying (student LM) on 5/6/24.
//

import SwiftUI

struct PlacesInputView: View {
    @EnvironmentObject var places: PlaceData
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                Text("Search Places")
                    .font(Constants.mediumFont)
                Spacer()
                TextField("To", text: $places.query)
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(Constants.mediumFont)
                    .border(Color.valeaseOrange, width: 4)
                    .padding()
                Spacer()
              
                if (places.query != ""){
                    
                    NavigationLink(destination: FlightView()
                        .task {
                            await places.loadData()
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

struct PlacesInputView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesInputView()
            .environmentObject(PlaceData())
    }
}
