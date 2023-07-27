//
//  ContentView.swift
//  MoodTracker
//
//  Created by Mustafa on 27.07.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("rate_your_day")
            .navigationTitle("mood_tracker")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
        .environment(\.locale, .init(identifier: "en"))
        NavigationView {
            ContentView()
        }
        .environment(\.locale, .init(identifier: "tr"))
    }
}
