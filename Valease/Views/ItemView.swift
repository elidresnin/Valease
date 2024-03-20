//
//  ItemView.swift
//  Valease
//
//  Created by Francesca Schneider (student LM) on 3/19/24.
//

import SwiftUI

struct ItemView: View {
    
    @ObservedObject var item: Item
    var addItem: (Item) -> Void
    let alerts = ["None", "1 hr before trip", "2 hr before trip", "12 hr before trip", "1 day before trip"]
    @State private var selectedReminder = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("New Item")
                    .font(Constants.mediumFont)
                    .padding(20)
                Spacer()
            }
            TextField("Item", text: $item.name)
                .padding(20)
            TextField("Quantity", text: $item.quantity)
                .padding(20)
            HStack {
                Toggle("Set Reminder", isOn: $item.setReminder)
                    .padding(20)
            }
            if item.setReminder {
                HStack {
                    Text("Alert")
                        .padding(20)
                    Spacer()
                    Picker("Alert", selection: $selectedReminder, content: {
                        ForEach(0..<alerts.count) { index in
                            Text(alerts[index])
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                    .padding(20)
                }
            }
            Spacer()
            Button {
                addItem(item)
            } label: {
                Text("Add Item")
            }.padding()
        }
    }
    
    struct ItemView_Previews: PreviewProvider {
        static var previews: some View {
            ItemView(item: Item(), addItem: {_ in})
        }
    }
}
