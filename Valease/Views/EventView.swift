//
//  EventView.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/20/24.
//

import SwiftUI

struct EventView: View {
    @ObservedObject var event: Event
    var addEvent: (Event) -> Void
    //let alerts = ["None", "1 hr before trip", "2 hr before trip", "12 hr before trip", "1 day before trip"]
    // @State private var selectedReminder = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("New Event")
                    .font(Constants.mediumFont)
                    .padding(20)
                Spacer()
            }
            TextField("Name", text: $event.name)
                .padding(20)
            TextField("Location", text: $event.location)
                .padding(20)
            TextField("Date", text: $event.date)
                .padding(20)
            TextField("Time", text: $event.time)
                .padding(20)
            //            HStack {
            //                Toggle("Set Reminder", isOn: $event.setReminder)
            //                    .padding(20)
            //            }
            //            if item.setReminder {
            //                HStack {
            //                    Text("Alert")
            //                        .padding(20)
            //                    Spacer()
            //                    Picker("Alert", selection: $selectedReminder, content: {
            //                        ForEach(0..<alerts.count) { index in
            //                            Text(alerts[index])
            //                        }
            //                    })
            //                    .pickerStyle(MenuPickerStyle())
            //                    .padding(20)
            //                }
            //            }
            Spacer()
            Button {
                addEvent(event)
            } label: {
                Text("Add event")
            }.padding()
        }
    }
    
    struct EventView_Previews: PreviewProvider {
        static var previews: some View {
            EventView(event: Event(), addEvent: {_ in})
        }
    }
}
