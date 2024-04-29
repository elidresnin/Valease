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

struct AirlineInfo: Codable {
    var logo_url: String = ""
    var name: String = ""
    
}

class FlightData: ObservableObject {
    @Published var flightResponse: FlightResponse = FlightResponse()
    @Published var fly_from: String
    @Published var fly_to: String
    @Published var date_from: String
    @Published var date_to: Date
    
    @Published var aInfo: (String?, String?) = ("","")
    @Published var results: [Flight] = [Flight()]
    
    
    
    init(fly_from: String = "", fly_to: String = "", date_from: String = "", date_to: Date = Date.init()) {
        self.fly_from = fly_from
        self.fly_to = fly_to
        self.date_from = date_from
        self.date_to = date_to
    }
    
    
    
    func loadData() async {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let url = URL(string: "https://api.tequila.kiwi.com/v2/search?fly_from=\(self.fly_from)&fly_to=\(self.fly_to)&date_from=\(formatter.string(from: date_to))&date_to=\(formatter.string(from: date_to))&max_stopovers=0&curr=USD")!
        var request = URLRequest(url: url)
        request.setValue("VxAXJ1efWqww-_ihywdKLEsCOcFPSPJj", forHTTPHeaderField: "apikey")
        guard let (data, _) = try? await URLSession.shared.data(for: request) else {return print("error at urlsession")}
        guard let decoded = try? JSONDecoder().decode(FlightResponse.self, from: data) else {return print("localizedDescription")}
        flightResponse = decoded
        
        
        parseData()
        
        
    }
    
    
    func parseData() {
        
        let dateFormatter = ISO8601DateFormatter()
        var count = 0
        results.removeAll()
        for f in flightResponse.data {
            Task {
                aInfo  = await fetchAirlineInfo(airline: f.airlines.first ?? "err")
                
            }
            results.append(Flight(airline: f.airlines.first ?? "err", flightNumber: f.route.first?.flight_no ?? 0, price: f.price, departure: f.route.first?.local_departure ?? "", arrival: f.route.first?.local_arrival ?? "", airlineName: aInfo.0 ?? "Err", logoURL: aInfo.1 ?? "ERr", deepLink: f.deep_link))
            count += 1
        }
        
        
    }
    
    
  
     func fetchAirlineInfo(airline: String) async -> (String?, String?) {
       
        
        let url = URL(string: "https://api.api-ninjas.com/v1/airlines?iata=\(airline)")!
        var request = URLRequest(url: url)
        request.setValue("bgxIHx/vAkKSP1sQg/eekQ==6ObiI1tlak89dl8T", forHTTPHeaderField: "X-Api-Key")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode([AirlineInfo].self, from: data)
            if let airlineInfo = decoded.first {
                // Update airline name and logo URL for the current flight
                return (airlineInfo.name, airlineInfo.logo_url)
            }
        } catch {
           print("Error fetching airline information: \(error)")
            return (nil, nil)
        }
         return ("wtf", "wtf")
       
    }

    
    
    
}

//dateFormatter.date(from: f.route.first?.local_departure ?? "")
