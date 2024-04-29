//
//  ValeaseApp.swift
//  Valease
//
//  Created by Eli Dresnin (student LM) on 3/8/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct ValeaseApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var user: User = User()
    @StateObject var trips: Trips = Trips()

    @StateObject var flights: FlightData = FlightData()

    @StateObject var items: Items = Items()
    @StateObject var events: Events = Events()

    
    var body: some Scene {
        WindowGroup {
            FlightInputView()
                .environmentObject(user)
                .environmentObject(trips)

                .environmentObject(flights)

                .environmentObject(items)
                .environmentObject(events)

        }
    }
}
