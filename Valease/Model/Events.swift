//
//  Events.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 4/9/24.
//

import SwiftUI

class Events : ObservableObject {
    @Published var eventList: [Event] = [
        Event(name: "Default", location: "Miami Beach")
    ]
}

