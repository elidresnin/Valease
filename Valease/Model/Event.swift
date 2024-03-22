//
//  Event.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/20/24.
//

import SwiftUI

class Event: Identifiable, ObservableObject {
    @Published var name: String
    @Published var location: String
    @Published var date: Date
    @Published var time: String
    let id = UUID()
    
    init(name: String = "", location: String = "", date: Date = Date(), time: String = "") {
        self.name = name
        self.location = location
        self.date = date
        self.time = time
    }
    
}
