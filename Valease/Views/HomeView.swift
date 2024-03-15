//
//  HomeView.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/14/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink{
                    PackingView()
                } label: {
                    VStack{
                        Text("Packing List")
                            .font(Constants.largeFont)
                            .fontWeight(.bold)
                            .foregroundColor(Color.valeaseOrange)
                        Image("packing")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                    }
                }
                
                Spacer()
                
                NavigationLink{
                    ItineraryView()
                } label: {
                    VStack{
                        Text("Itinerary")
                            .font(Constants.largeFont)
                            .fontWeight(.bold)
                            .foregroundColor(Color.valeaseOrange)
                        Image("plan")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                    }
                }
            }
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
