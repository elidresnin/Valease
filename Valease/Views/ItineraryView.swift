//
//  ItineraryView.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/15/24.
//

import SwiftUI

struct ItineraryView: View {
    @State var showSheet = false
    @State var events: [Event] = []
    
    func addEvent(event: Event) {
        events.append(event)
        showSheet.toggle()
    }
    
    func deleteEvent(at indexSet: IndexSet) {
            events.remove(atOffsets: indexSet)
    }
    
    func moveEvent(from source: IndexSet, to destination: Int) {
            events.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        showSheet.toggle()
                    }) {
                        Text("+ Add item")
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
                    ForEach(events) { event in
                        Text(event.name)
                    }
                    .onDelete(perform: deleteEvent)
                    .onMove(perform: moveEvent)
                }.listStyle(PlainListStyle())
            }
            .padding()
            .navigationBarTitle("Itinerary")
        }
        .sheet(isPresented: $showSheet) {
       EventView(event: Event(), addEvent: { event in
            self.events.append(event)
            self.showSheet.toggle()
            })
        }
    }
}

struct ItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        ItineraryView()
            .environmentObject(Event())
    }
}
