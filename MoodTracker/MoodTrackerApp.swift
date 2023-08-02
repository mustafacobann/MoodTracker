//
//  MoodTrackerApp.swift
//  MoodTracker
//
//  Created by Mustafa on 27.07.2023.
//

import SwiftUI

@main
struct MoodTrackerApp: App {

    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
