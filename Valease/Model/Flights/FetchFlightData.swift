//
//  FetchFlightData.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 3/21/24.
//

import SwiftUI


struct FlightResponse: Codable {
    var search_id: String = "failed :("
    var data: [Data] = [Data()]
}



struct Data: Codable {
    var id: String = "err"
    var quality: Double = 0.0
    var price: Int = 0
    var airlines: [String] = ["err at airlines"]
    var route: [Route] = [Route()]
    var deep_link: String = ""
    
}

struct Route: Codable {
    var cityFrom: String = ""
    var cityTo: String = ""
    var local_departure: String = ""
    var local_arrival: String = ""
    var airline: String = ""
    var flight_no: Int = 0
}



class FlightData: ObservableObject {
    @Published var flightResponse: FlightResponse = FlightResponse()
    @Published var fly_from: String
    @Published var fly_to: String
    @Published var date_from: String
    @Published var date_to: String
    
    
    init(fly_from: String = "phl", fly_to: String = "ORD", date_from: String = "04/04/2024", date_to: String = "08/04/2024") {
        self.fly_from = fly_from
        self.fly_to = fly_to
        self.date_from = date_from
        self.date_to = date_to
    }
    
    
    
    func loadData() async {
        
        let url = URL(string: "https://api.tequila.kiwi.com/v2/search?fly_from=\(self.fly_from)&fly_to=\(self.fly_to)&date_from=\(self.date_to)&date_to=\(self.date_to)&limit=5&max_stopovers=0&curr=USD")!
        var request = URLRequest(url: url)
        request.setValue("VxAXJ1efWqww-_ihywdKLEsCOcFPSPJj", forHTTPHeaderField: "apikey")
        guard let (data, _) = try? await URLSession.shared.data(for: request) else {return print("error at urlsession")}
        guard let decoded = try? JSONDecoder().decode(FlightResponse.self, from: data) else {return print("at decoded")}
        flightResponse = decoded
    }
}

