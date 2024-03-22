//
//  Flight.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 3/21/24.
//

import Foundation

struct Flight: Identifiable {
    var airline: String = ""
    var flightNumber: Int = 0
    var price: Int = 0
    var departure: String = ""
    var arrival: String = ""
    var id = UUID()

}
