//
//  Item.swift
//  Valease
//
//  Created by Francesca Schneider (student LM) on 3/19/24.
//

import SwiftUI

class Item: Identifiable, ObservableObject {
    var name: String
    var quantity: String
    var setReminder: Bool
    var selectedReminder: String
    var checked: Bool
    var selectedReminderIndex: Int
    let id = UUID()
    
    static let alerts = ["None", "1 hr before trip", "2 hr before trip", "12 hr before trip", "1 day before trip"]
    
    init(name: String = "", quantity: String = "", setReminder: Bool = false, selectedReminder: String = "", checked: Bool = false, selectedReminderIndex: Int = 0) {
        self.name = name
        self.quantity = quantity
        self.setReminder = setReminder
        self.selectedReminder = selectedReminder
        self.checked = checked
        self.selectedReminderIndex = selectedReminderIndex
        
    }
    
}
