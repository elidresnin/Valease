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
    
    var body: some View {
        VStack {
            if user.loggedIn{
                if viewState == .home{
                    HomeView()
                } else if viewState == .account{
                    AccountView()
                } else if viewState == .flights{
                    FlightInputView(currentTrip: $currentTrip)
                } else {
                    PlacesInputView(currentTrip: $currentTrip)
                }
                HStack{
                    Button {
                        viewState = .home
                    } label: {
                        VStack{
                            Image(systemName: "house")
                                .font(.largeTitle)
                                .foregroundColor(Color.valeaseGreen)
                            
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        viewState = .places
                    } label: {
                        VStack{
                            Image(systemName: "map")
                                .font(.largeTitle)
                                .foregroundColor(Color.valeaseGreen)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        viewState = .flights
                    } label: {
                        VStack{
                            Image(systemName: "airplane")
                                .font(.largeTitle)
                                .foregroundColor(Color.valeaseGreen)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        viewState = .account
                    } label: {
                        VStack{
                            Image(systemName: "person")
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
