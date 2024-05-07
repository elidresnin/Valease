//
//  PlacesView.swift
//  Valease
//
//  Created by Bole Ying (student LM) on 5/6/24.
//

import SwiftUI
import MapKit


struct AnyMapAnnotationProtocol: MapAnnotationProtocol {
  let _annotationData: _MapAnnotationData
  let value: Any

  init<WrappedType: MapAnnotationProtocol>(_ value: WrappedType) {
    self.value = value
    _annotationData = value._annotationData
  }
}
struct PlacesView: View {
    @EnvironmentObject var places: PlaceData
    
    var body: some View {
        VStack{
            Map(coordinateRegion: .constant(places.region!),showsUserLocation: true, annotationItems: places.places) { item in
                AnyMapAnnotationProtocol(MapAnnotation(coordinate: item.coordinate) {
                    NavigationLink {
                        PlacesDetailView(place: item)
                    } label: {
                        Image(systemName: "mappin.circle.fill")
                                                    .font(.title)
                                                    .foregroundColor(.red)
                    }

                            })
                    }
                .ignoresSafeArea()
                
//                List(places.places){ place in
//                    NavigationLink (destination:  {
//                        PlacesDetailView(place: place)
//                    }, label: {
//                        VStack{
//                            Text("\(place.name)")
//                            Text("\(place.address)")
//                            Text("\(String(place.rating))")
//                            
//                            
//                        }
//                        .padding()
//                        
//                    })
//                }
                
                .task {
                    //                await places.loadData()
                    
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
    
    struct PlaceAnnotationView: View {
        var body: some View {
            VStack(spacing: 0) {
                Image(systemName: "mappin.circle.fill")
                    .font(.title)
                    .foregroundColor(.red)
                
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(.red)
                    .offset(x: 0, y: -5)
            }
        }
    }
