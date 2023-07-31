//
//  HomeView.swift
//  MoodTracker
//
//  Created by Mustafa on 27.07.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 0) {
            DayRatingView()

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(Rating.mockRatings) { rating in
                        RatingRow(rating: rating)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                    }
                }
                .padding(.top, 12)
            }
        }
        .clipped()
        .navigationTitle("mood_tracker")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.orange)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
        .environment(\.locale, .init(identifier: "en"))
        NavigationView {
            HomeView()
        }
        .environment(\.locale, .init(identifier: "tr"))
    }
}
