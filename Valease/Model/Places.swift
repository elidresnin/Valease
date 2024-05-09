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
    var photos: [Photos]
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

struct Photos: Codable {
    var photo_reference: String = ""
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
           
            places.append(Place(business_status: f.business_status, address: f.formatted_address, name: f.name,  price_level: f.price_level, rating: f.rating, types: f.types, location: (f.geometry.location.lat, f.geometry.location.lng), region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: f.geometry.location.lat, longitude: f.geometry.location.lng), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), photo: f.photos[0].photo_reference))
        }
        places.sort(by: {$0.rating > $1.rating})
        
        let bounds = calculateRegion()
        
        region = MKCoordinateRegion(center: bounds.0, span: bounds.1)
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
    func calculateRegion(cushionPercentage: Double = 0.1) -> (center: CLLocationCoordinate2D, span: MKCoordinateSpan) {
            guard !places.isEmpty else {
                // If places array is empty, provide a default region or make an assumption
                let defaultRegionCenter = CLLocationCoordinate2D(latitude: 0, longitude: 0)
                let defaultRegionSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                return (defaultRegionCenter, defaultRegionSpan)
            }
            
            // Calculate bounding box with cushion
            let boundingBox = { () -> (minLat: Double, maxLat: Double, minLng: Double, maxLng: Double) in
                var minLat = places[0].location.0
                var maxLat = places[0].location.0
                var minLng = places[0].location.1
                var maxLng = places[0].location.1
                
                for place in places {
                    let lat = place.location.0
                    let lng = place.location.1
                    minLat = min(minLat, lat)
                    maxLat = max(maxLat, lat)
                    minLng = min(minLng, lng)
                    maxLng = max(maxLng, lng)
                }
                
                let latDelta = maxLat - minLat
                let lngDelta = maxLng - minLng
                
                let cushionLat = latDelta * cushionPercentage
                let cushionLng = lngDelta * cushionPercentage
                
                return (minLat - cushionLat, maxLat + cushionLat, minLng - cushionLng, maxLng + cushionLng)
            }()
            
            let centerLat = (boundingBox.minLat + boundingBox.maxLat) / 2.0
            let centerLng = (boundingBox.minLng + boundingBox.maxLng) / 2.0
            let center = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLng)
            
            let span = MKCoordinateSpan(latitudeDelta: boundingBox.maxLat - boundingBox.minLat,
                                        longitudeDelta: boundingBox.maxLng - boundingBox.minLng)
            
            return (center, span)
        }
   
}

struct Place: Identifiable {
    var business_status: String = "closed"
    var address: String = "101 W Levering Mill Rd, Bala Cywnyd PA 19004"
    var name: String = "Cynwyd Elementry School"
    var price_level: Int? = 0
    var rating: Double = 4.0
    var types: [String] = []
    var location: (Double, Double) = (0.0, 0.0)
    var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.75773, longitude: -73.985708), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: location.0, longitude: location.1)
        }
    var photo: String =  "AUGGfZl2YOQM_kOCNB6N-RN3M8BYuoD9TYXY4p7z5sH-sQ8ExgA6n9JI1_KVvIgPb4Tx-1IIxApN-fovPXiw5ZcmbaIrjqyWGfaLDsWV8prrxClWrlQhZWbhfOxUiXUTEzCBcOKj9TotBk9vgm54f7HCaHwK6YVK6yXCoMaMSiG2pI9AxjXB"
    var id = UUID()
    var date: Date = Date()
}
