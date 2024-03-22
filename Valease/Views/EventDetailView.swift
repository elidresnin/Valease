//
//  EventDetailView.swift
//  Valease
//
//  Created by Francesca Schneider (student LM) on 3/21/24.
//

import SwiftUI

struct EventDetailView: View {
    
    @ObservedObject var event: Event
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("yyMMddhhmm")
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Text(event.name)
                    .font(Constants.mediumFont)
                    .padding(20)
            }
            Text("Location: \(event.location)")
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Date: \(event.date, formatter: Self.formatter)")
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(event: Event())
    }
}
