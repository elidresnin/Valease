//
//  PlacesDetailView.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 5/7/24.
//

import SwiftUI
import MapKit

struct PlacesDetailView: View {
    @EnvironmentObject var places: PlaceData
    @State var place: Place
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $place.region)
                .ignoresSafeArea()
            Spacer()
            Spacer()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Spacer()
        }
    }
}

struct PlacesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesDetailView(place: Place())
            .environmentObject(PlaceData())
    }
}
