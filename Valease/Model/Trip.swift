//
//  Trip.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/19/24.
//

import SwiftUI

struct Trip: Identifiable{
    var name: String
    var location: String
    var dates: Date
    var events : Events
    var items : Items
    let id = UUID()
    
    init(name: String = "", location: String = "", dates: Date = Date(), events: Events = Events(), items : Items = Items()) {
        self.name = name
        self.location = location
        self.dates = dates
        self.events = events
        self.items = items
    }
    
//    func make_dictionary(){
//        [String:String]
//    }
}

