//
//  EventView.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/20/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct EventView: View {
    @EnvironmentObject var events: Events
    @Binding var event: Event
    @Binding var showSheet: Bool
    @State private var isShowingPicker = false
    var addEvent: (Event, Date) -> Void
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("yyMMddhhmm")
        return formatter
    }()
    
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
            Button(action: {
                self.isShowingPicker.toggle()
            }) {
                Text("Date: \(event.date, formatter: Self.formatter)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
            }
            .sheet(isPresented: $isShowingPicker) {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.isShowingPicker = false
                        }) {
                            Text("Cancel")
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        Button(action: {
                            self.isShowingPicker = false
                        }) {
                        Text("Done")
                        }.frame(maxWidth: .infinity, alignment: .trailing)
                        Spacer()
                    }
                    .padding()
                    DatePicker("", selection: $event.date, in: Date()..., displayedComponents: [.hourAndMinute, .date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                }
            }
            Spacer()
            Button {
                addEvent(event, event.date)
                self.showSheet = false
            } label: {
                Text("Add event")
            }.padding()
                .onSubmit {
                    guard let uid = Auth.auth().currentUser?.uid else {return}
                    Database.database().reference().child("users/\(uid)/events/\(event.id)/name").setValue(event.name)
                    Database.database().reference().child("users/\(uid)/events/\(event.id)/location").setValue(event.location)
                }
        }
    }
    
    struct EventView_Previews: PreviewProvider {
            
        static var previews: some View {
            EventView(event: .constant(Event()), showSheet: .constant(true), addEvent: { _, _ in })
                .environmentObject(Events())
        }
    }
}
