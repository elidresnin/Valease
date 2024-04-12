//
//  TripDetailView.swift
//  Valease
//
//  Created by Francesca Schneider (student LM) on 3/20/24.
//

import SwiftUI

struct TripDetailView: View {
    @EnvironmentObject var allTrips: Trips
    @Binding var isSheetPresented: Bool
    @State var trip = Trip()
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var selectionState: SelectionState? = nil
    var addTrip: (Trip) -> Void
    
    enum SelectionState: Identifiable {
        case startDate, endDate
        
        var id: Int {
            switch self {
                case .startDate: return 0
                case .endDate: return 1
            }
        }
    }
    
//    func addTrip() {
//        allTrips.tripList.append(trip)
//        isSheetPresented = false
//    }
    
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func datePickerSheet(selectedDate: Binding<Date>, isPresented: Binding<Bool>, isStartDate: Bool) -> some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isPresented.wrappedValue = false
                    selectionState = nil
                }) {
                    Text("Cancel")
                }.padding()
                Spacer()
                Text("Select \(isStartDate ? "Start" : "End") Date")
                    .font(.headline)
                Spacer()
                Button(action: {
                    isPresented.wrappedValue = false
                    selectionState = nil
                }) {
                    Text("Done")
                }.padding()
                Spacer()
            }
            DatePicker("", selection: selectedDate, in: (isStartDate ? Date()... : startDate...) , displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .padding()
        }
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Text("New Trip")
                    .font(Constants.mediumFont)
                    .padding(20)
                Spacer()
            }
            TextField("Name", text: $trip.name)
                .padding(20)
            TextField("Location", text: $trip.location)
                .padding(20)
            
            VStack {
                HStack {
                    Button(action: {
                        selectionState = .startDate
                    }) {
                        Text("Start Date: \(formattedDate(date: startDate))")
                    }.padding()
                    Spacer()
                    Button(action: {
                        selectionState = .endDate
                    }) {
                        Text("End Date: \(formattedDate(date: endDate))")
                    }.padding()
                    Spacer()
                }
            }
            Spacer()
            Button {
                addTrip(trip)
                isSheetPresented = false
            } label: {
                Text("Add Trip")
            }.padding()
        }.sheet(item: $selectionState) { state in
            datePickerSheet(selectedDate: state == .startDate ? $startDate : $endDate, isPresented: .constant(true), isStartDate: state == .startDate)
        }
    }
}

struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TripDetailView(isSheetPresented: .constant(false), trip: Trip(), addTrip: {_ in})
            .environmentObject(Trips())
    }
}
