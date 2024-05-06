//
//  PlacesView.swift
//  Valease
//
//  Created by Bole Ying (student LM) on 5/6/24.
//

import SwiftUI


struct PlacesView: View {
    @EnvironmentObject var places: PlaceData
    var body: some View {
        VStack{
            Text(places.query)
            List(places.places){ place in
                NavigationLink (destination: {
                    
                }, label: {
                    VStack{
                        Text("\(place.name)")
                        Text("\(place.address)")
                        
                        
                    }
                    .padding()
                    
                })
            }
            .task {
                await places.loadData()
                    
                }
                
            }
            
        }
    }


struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView()
            .environmentObject(PlaceData())
    }
}
