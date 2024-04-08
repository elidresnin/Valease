//
//  ItineraryView.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/15/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct ItineraryView: View {
    @State private var showSheet = false
    @State private var events: [Event] = []
    
    func saveEvent(name: String, location: String, id: UUID) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
       
        let eventObject = [
            "name" : name,
            "location" : location,
            "id" : id
        ] as [String: Any]
        
        let databaseRef = Database.database().reference().child("users/\(uid)/events/\(id)")
        
//        let eventObject = [
//            "name" : name,
//            "location" : location,
//            "id" : id
//        ] as [String: Any]
        
        databaseRef.setValue(eventObject)
    }
    
    func addEvent(event: Event, date: Date) {
        let newEvent = Event(name: event.name, location: event.location, date: event.date, time: event.time)
        events.append(newEvent)
        showSheet.toggle()
        saveEvent(name: newEvent.name, location: newEvent.location, id: newEvent.id)
    }
    
    func deleteEvent(at indexSet: IndexSet) {
            events.remove(atOffsets: indexSet)
    }
    
    func moveEvent(from source: IndexSet, to destination: Int) {
            events.move(fromOffsets: source, toOffset: destination)
    }
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("yyMMddhhmm")
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        showSheet.toggle()
                    }) {
                        Text("+ Add event")
                            .font(Constants.mediumFont)
                    }
                    .padding(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    EditButton()
                        .font(Constants.mediumFont)
                        .padding(20)
                }
                List {
                    ForEach(events.sorted(by: {$0.date < $1.date})) { event in
                        HStack {
                            Text(event.name)
                            Spacer()
                            Text(event.date, formatter: ItineraryView.formatter)
                        }
                        
                    }
                    .onDelete(perform: deleteEvent)
                    .onMove(perform: moveEvent)
                }.listStyle(PlainListStyle())
            }
            .padding()
            .navigationBarTitle("Itinerary")
        }
        .sheet(isPresented: $showSheet) {
            EventView(event: .constant(Event()), showSheet: $showSheet, addEvent: self.addEvent)
        }
    }
}

struct ItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        ItineraryView()
            .environmentObject(Event())
    }
}
