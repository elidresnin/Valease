//
//  Trips.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/19/24.
//

import SwiftUI

class Trips : ObservableObject {
    @Published var tripList: [Trip] = [
        Trip(name: "Default", location: "Miami, Florida")
    ]
}
