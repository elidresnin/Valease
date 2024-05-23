//
//  ContentView.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 3/8/24.
//

import SwiftUI

enum ViewState{
    case home, account, flights, places
}

struct ContentView: View {
    @EnvironmentObject var user: User
    @EnvironmentObject var trips: Trips
    @Binding var currentTrip: Trip
    @State var viewState: ViewState = .home
    @State var homeIcon = "house"
    @State var mapIcon = "map"
    @State var planeIcon = "paperplane"
    @State var accountIcon = "person"
    
    var body: some View {
        VStack {
            if user.loggedIn{
                if viewState == .home{
                    HomeView()
                } else if viewState == .account{
                    AccountView()
                } else if viewState == .flights{
                    FlightInputView(currentTrip: $currentTrip)
                } else if viewState == .places{
                    PlacesInputView(currentTrip: $currentTrip)
                }
                HStack{
                    Button {
                        homeIcon = "house.fill"
                        mapIcon = "map"
                        planeIcon = "paperplane"
                        accountIcon = "person"
                        viewState = .home
                  
                    } label: {
                        VStack{
                            Image(systemName: homeIcon)
                                .font(.largeTitle)
                                .foregroundColor(Color.valeaseGreen)
                            
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        homeIcon = "house"
                        mapIcon = "map.fill"
                        planeIcon = "paperplane"
                        accountIcon = "person"
                        viewState = .places
                        
                        
                    } label: {
                        VStack{
                            Image(systemName: mapIcon)
                                .font(.largeTitle)
                                .foregroundColor(Color.valeaseGreen)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        
                        homeIcon = "house"
                        mapIcon = "map"
                        planeIcon = "paperplane.fill"
                        accountIcon = "person"
                        viewState = .flights
                    } label: {
                        VStack{
                            Image(systemName: planeIcon)
                                .font(.largeTitle)
                                .foregroundColor(Color.valeaseGreen)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        homeIcon = "house"
                        mapIcon = "map"
                        planeIcon = "paperplane"
                        accountIcon = "person.fill"
                        viewState = .account
                        
                    } label: {
                        VStack{
                            Image(systemName: accountIcon)
                                .font(.largeTitle)
                                .foregroundColor(Color.valeaseGreen)
                        }
                    }
                }
                .padding([.leading, .trailing], 40)
                .padding([.top], 20)
//                .padding([.bottom], -25)
            } else{
                SignupView()
            }
            
        }
//        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentTrip: Binding.constant(Trip()))
            .environmentObject(User())
            .environmentObject(Trips())
            .environmentObject(Items())
            .environmentObject(Events())
    }
}
