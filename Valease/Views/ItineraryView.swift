//
//  ItineraryView.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/15/24.
//

import SwiftUI

struct ItineraryView: View {
    @State private var showSheet = false
    @State private var events: [Event] = []
    @State private var newEvent: Event = Event()
    
    func addEvent(event: Event, date: Date) {
        events.append(event)
        showSheet.toggle()
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
            EventView(event: $newEvent, addEvent: { event, date in
                self.events.append(event)
                self.showSheet = false
            }, showSheet: $showSheet)
        }
    }
}

struct ItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        ItineraryView()
            .environmentObject(Event())
    }
}
