//
//  sleepTrackerHackathonApp.swift
//  Shared
//
//  Created by Rosalie Wessels on 2/27/21.
//

import SwiftUI
import Firebase

@main
struct sleepTrackerHackathonApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
