//
//  Flight.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 3/21/24.
//

import Foundation

struct Flight: Identifiable {
    var airline: String = "err"
    var flightNumber: Int = 999
    var price: Int = 123
    var departure: String = ""
    var arrival: String = ""
    var airlineName = "Pan Am"
    var logoURL = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Ford_logo_flat.svg/2560px-Ford_logo_flat.svg.png"
    var deepLink = "https://www.google.com"
    var departureDate: Date?
    var arrivalDate: Date? 
    var id = UUID()

    
}
