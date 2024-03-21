//
//  Trip.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/19/24.
//

import Foundation

struct Trip: Identifiable{
    var name: String
    var location: String
    var dates: Date
    let id = UUID()
    
    init(name: String = "Spring Break", location: String = "Miami, Florida", dates: Date = Date()) {
        self.name = name
        self.location = location
        self.dates = dates
    }
}

