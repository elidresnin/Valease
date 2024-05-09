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
    @EnvironmentObject var events : Events
    @State private var isShowingPicker = false
    
    var body: some View {

        VStack {
            AsyncImage(
                url: URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photo_reference=\(place.photo)&key=AIzaSyDNMYZ6l67iAy_HCSjAAl6Ljrj1oVLWseY"),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: UIScreen.main.bounds.height/2)
                        .ignoresSafeArea()
                        
                },
                placeholder: {
                    ProgressView()
                        .frame(height: UIScreen.main.bounds.height/2)
                    
                }
            )
            ScrollView{
                
                Text(place.name)
                    .font(Constants.mediumFont)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                Text(place.address)
                    .font(Constants.mediumFont)
                    .multilineTextAlignment(.center)
                    .padding()
                Text(place.business_status)
                    .multilineTextAlignment(.center)
                    .padding()
                
                if let _ = place.price_level{
                    Text("Price Level: \(String(place.price_level ?? 0))/4")
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                
                HStack{
                    ForEach(0..<Int(place.rating)) {_ in
                        return Image(systemName: "star.fill")
                            .foregroundColor(Color.valeaseOrange)
                    }
                    ForEach(Int(place.rating)..<5) {_ in
                        return Image(systemName: "star")
                            .foregroundColor(Color.valeaseOrange)
                    }
                }
                
                DatePicker("Select a date", selection: $place.date, in: Date()..., displayedComponents: [.hourAndMinute, .date])
                    .padding()
                
                
                Button {
                    
                    let newPlace = Event(name: place.name, location: place.address, date: place.date)
                    
                    events.eventList.append(newPlace)
                    
                } label: {
                    Text("Add to itinerary")
                        .padding()
                        .background(Color.valeaseTeal)
                        .cornerRadius(30)
                    
                    
                }
                
                
                
            }
           
        }
    }
}

struct PlacesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesDetailView(place: Place())
            .environmentObject(PlaceData())
            .environmentObject(Events())
    }
}
