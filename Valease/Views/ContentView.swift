//
//  ContentView.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 3/8/24.
//

import SwiftUI

enum ViewState{
    case home, account
}

struct ContentView: View {
    @EnvironmentObject var user: User
    @State var viewState: ViewState = .home
    
    var body: some View {
        VStack {
            if user.loggedIn{
                if viewState == .home{
                    HomeView()
                } else {
                    AccountView()
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
                        
                    } label: {
                        VStack{
                            Image(systemName: "map")
                                .font(.largeTitle)
                                .foregroundColor(Color.valeaseGreen)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                       
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
                .padding([.top], 35)
                .padding([.bottom], -25)
            } else{
                SignupView()
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(User())
            .environmentObject(Trips())
    }
}
