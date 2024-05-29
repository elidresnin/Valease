//
//  ItemDetailView.swift
//  Valease
//
//  Created by Francesca Schneider (student LM) on 3/20/24.
//

import SwiftUI

struct ItemDetailView: View {
    
    @ObservedObject var item: Item
    @State private var selectedReminder = 0
    let alerts = ["None", "1 hr before trip", "2 hr before trip", "12 hr before trip", "1 day before trip"]
    
    var body: some View {
        VStack {
            HStack {
                Text(item.name)
                    .font(Constants.mediumFont)
                    .padding(20)
            }
            Text("Quantity: \(item.quantity)")
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
//            HStack {
//                Toggle("Set Reminder", isOn: $item.setReminder)
//                    .padding(20)
//            }
            //if item.setReminder {
                HStack {
                    Text("Alert")
                        .padding(20)
                    Spacer()
                    Text(alerts[item.selectedReminderIndex])
                        .padding(20)
                }
           // }
            Spacer()
        }
        .onAppear {
            if !(0..<alerts.count).contains(item.selectedReminderIndex) {
                item.selectedReminderIndex = 0
            }
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(item: Item())
            .environmentObject(Items())
    }
}
