//
//  ItemView.swift
//  Valease
//
//  Created by Francesca Schneider (student LM) on 3/19/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct ItemView: View {
    
    @ObservedObject var item: Item
    var addItem: (Item) -> Void
    
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
                    Picker("Alert", selection: $item.selectedReminderIndex) {
                        ForEach(0..<Item.alerts.count) { index in
                            Text(Item.alerts[index])
                        }
                    }
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
                .onSubmit {
                    guard let uid = Auth.auth().currentUser?.uid else {return}
                    Database.database().reference().child("users/\(uid)/items/\(item.id)/name").setValue(item.name)
                    Database.database().reference().child("users/\(uid)/items/\(item.id)/quantity").setValue(item.quantity)
                }
        }
    }
    
    struct ItemView_Previews: PreviewProvider {
        static var previews: some View {
            ItemView(item: Item(), addItem: {_ in})
        }
    }
}
