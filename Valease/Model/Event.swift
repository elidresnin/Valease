//
//  Event.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/20/24.
//

import SwiftUI


class Event: Identifiable, ObservableObject {
    var name: String
    var location: String
    var date: Date
    var time: String
    let id = UUID()
    
    init(name: String = "", location: String = "", date: Date = Date(), time: String = "") {
        self.name = name
        self.location = location
        self.date = date
        self.time = time
    }
    
//    func make_dictionary(){
//        
//        let stuff :Dictionary = ["name": name, "location": location, "date": date.toString()]
//        return  [id:[stuff]]
//    }
//    
}
