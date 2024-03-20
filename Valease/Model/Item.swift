//
//  Item.swift
//  Valease
//
//  Created by Francesca Schneider (student LM) on 3/19/24.
//

import SwiftUI

class Item: Identifiable, ObservableObject {
    @Published var name: String
    @Published var quantity: String
    @Published var setReminder: Bool
    @Published var selectedReminder: String
    @Published var checked: Bool
    
    init(name: String = "", quantity: String = "", setReminder: Bool = false, selectedReminder: String = "", checked: Bool = false) {
        self.name = name
        self.quantity = quantity
        self.setReminder = setReminder
        self.selectedReminder = selectedReminder
        self.checked = checked
    }
    
}
