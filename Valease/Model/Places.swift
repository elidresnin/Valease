//
//  Places.swift
//  Valease
//
//  Created by Bole Ying (student LM) on 5/6/24.
//
import SwiftUI
import CoreLocation
import MapKit

struct PlacesResponse: Codable{

    var results: [Results] = []
    var status: String = "dsfashiuihu"
}
struct Results: Codable {
    var business_status: String = ""
    var formatted_address: String = ""
    var name: String = ""
    var price_level: Int?
    var rating: Double = 0.0
    var types: [String] = []
    var geometry: Geometry
}

struct Geometry: Codable {
    var location: Location
}

struct Location: Codable {
    var lat: Double = 0.0
    var lng: Double = 0.0
}

class PlaceData: ObservableObject{
    
    @Published var placesResponse = PlacesResponse()
    
    
    @Published var query: String = ""
    @Published var places: [Place] = [Place()]
    
    @Published var region: MKCoordinateRegion =  MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
    let baseURL = "https://maps.googleapis.com/maps/api/place/textsearch/json"
    
    func loadData() async {
        
        var params = [
            "query": query,
            "inputtype": "textquery",
            "fields": "formatted_address,name",
            "key": "AIzaSyDNMYZ6l67iAy_HCSjAAl6Ljrj1oVLWseY"
        ]
        var components = URLComponents(string: self.baseURL)!
        components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components.url else {
            fatalError("Invalid URL")
        }
        print(url)

        guard let (data, _) = try? await URLSession.shared.data(from: url) else {return print("urlsession")}
        
        guard let t = try? JSONDecoder().decode(PlacesResponse.self, from: data) else {return print("error")}
        
        placesResponse = t
        
        for f in placesResponse.results {
           
            places.append(Place(business_status: f.business_status, address: f.formatted_address, name: f.name,  price_level: f.price_level, rating: f.rating, types: f.types, location: (f.geometry.location.lat, f.geometry.location.lng), region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: f.geometry.location.lat, longitude: f.geometry.location.lng), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))))
        }
        places.sort(by: {$0.rating > $1.rating})
        
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: avgLat(), longitude: avgLng()), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }
    
    func avgLat() -> Double {
        var total: Double = 0
        for p in places {
            total += p.location.0
        }
        return total/Double(places.count)
    }
    
    func avgLng() -> Double {
        var total: Double = 0
        for p in places {
            total += p.location.1
        }
        return total/Double(places.count)
    }
   
}

struct Place: Identifiable {
    var business_status: String = ""
    var address: String = "101 W Levering Mill Rd, Bala Cywnyd PA 19004"
    var name: String = "Cynwyd Elementry School"
    var price_level: Int?
    var rating: Double = 0.0
    var types: [String] = []
    var location: (Double, Double) = (0.0, 0.0)
    var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.75773, longitude: -73.985708), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: location.0, longitude: location.1)
        }
    var id = UUID()
}
