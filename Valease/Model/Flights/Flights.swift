//
//  Flight.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 3/21/24.
//

import Foundation

class Flights: ObservableObject {
    //inputted
    @Published var to: String
    @Published var from: String
    @Published var departureDate: String
    @Published var flightClass: String
    @Published var numPassengers: Int
    
    @Published var results: [Flight] = [Flight()]
    
   
    
    init(to: String = "PHL", from: String = "ORD", departureDate: String = "04/05/2024", flightClass: String = "", numPassengers: Int = 0) {
        self.to = to
        self.from = from
        self.departureDate = departureDate
        self.flightClass = flightClass
        self.numPassengers = numPassengers
    }
    
    func fetchData() {
        var result: FlightData = FlightData(fly_from: self.from, fly_to: self.to, date_to: self.departureDate)
        var count: Int = 0
        
        for f in result.flightResponse.data {
            results[count].airline = f.route[0].airline
            results[count].arrival = f.route[0].local_arrival
            results[count].departure = f.route[0].local_departure
            results[count].price = f.price
            results[count].flightNumber = f.route[0].flight_no
            count += 1
        }
    }
    
}
