//
//  Items.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 4/9/24.
//

import SwiftUI

class Items : ObservableObject {
    @Published var itemList: [Item] = [
        Item(name: "Default", quantity: "2")
    ]
}
