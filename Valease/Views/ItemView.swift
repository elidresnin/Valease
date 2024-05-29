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
    @EnvironmentObject var items: Items
    @ObservedObject var item: Item
    var addItem: (Item) -> Void
    @Binding var showSheet: Bool
    @Binding var currentTrip : Trip
    @State var reminderSet : Bool = false
    let alerts = ["None", "1 hr before trip", "2 hr before trip", "12 hr before trip", "1 day before trip"]
    @State private var selectedReminder  = 0
    
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
            //HStack {
                Toggle("Set Reminder", isOn: $reminderSet)
                    .padding(20)
            //}
           if reminderSet {
               
                HStack {
                    Text("Alert")
                        .padding(20)
                    Spacer()
                    Picker("Alert", selection: $selectedReminder) {
                        ForEach(0..<alerts.count) {i in
                            Text(alerts[i])
//                            item.selectedReminderIndex = selectedReminder
                      }
                    }
//                    Text(item.selectedReminder)
//                    .pickerStyle(MenuPickerStyle())
//                    .padding(20)
                }
            }
            Spacer()
            Button {
                item.selectedReminderIndex = selectedReminder
                addItem(item)
                showSheet = false
            } label: {
                Text("Add Item")
            }.padding()
                .onSubmit {
                    guard let uid = Auth.auth().currentUser?.uid else {return}
                    Database.database().reference().child("users/\(uid)/trips/\(currentTrip.id)/items/\(item.id)/name").setValue(item.name)
                    Database.database().reference().child("users/\(uid)/\(currentTrip.id)/items/\(item.id)/quantity").setValue(item.quantity)
                }
        }
    }
    
    struct ItemView_Previews: PreviewProvider {
        static var previews: some View {
            ItemView(item: Item(), addItem: {_ in}, showSheet: .constant(false), currentTrip: Binding.constant(Trip()))
                .environmentObject(Items())
        }
    }
}
