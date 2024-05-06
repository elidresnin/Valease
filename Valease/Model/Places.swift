//
//  Places.swift
//  Valease
//
//  Created by Bole Ying (student LM) on 5/6/24.
//
import SwiftUI
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
}

class PlaceData: ObservableObject{
    
    @Published var placesResponse = PlacesResponse()
    
    
    @Published var query: String = ""
    @Published var placesResults: [[String: Any]] = []
    @Published var places: [Place] = []
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

        guard let (data, _) = try? await URLSession.shared.data(from: url) else {return print("urlsession")}
        
        guard let t = try? JSONDecoder().decode(PlacesResponse.self, from: data) else {return print("error")}
        
        placesResponse = t
        
        for f in placesResponse.results {
            placesResults.append(["name": f.name, "business_status": f.business_status, "address": f.formatted_address,  "price_level": f.price_level, "rating": f.rating, "types" : f.types])
            places.append(Place(business_status: f.business_status, address: f.formatted_address, name: f.name,  price_level: f.price_level, rating: f.rating, types: f.types))
        }
    }
   
}

struct Place: Identifiable {
    var business_status: String = ""
    var address: String = ""
    var name: String = ""
    var price_level: Int?
    var rating: Double = 0.0
    var types: [String] = []
    var id = UUID()
}
