//
//  HomeView.swift
//  MoodTracker
//
//  Created by Mustafa on 27.07.2023.
//

import SwiftUI

struct HomeView: View {

    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)])
    private var ratings: FetchedResults<Rating>

    var last7DaysRatings: [Rating] {
        Array(ratings.prefix(7))
    }

    var body: some View {
        VStack(spacing: 12) {
            DayRatingView { selectedRating in
                saveTodaysRating(selectedRating)
            }

            Text("weekly_overview")
                .font(.custom(.varela, size: 20))

            RatingsChart(ratings: last7DaysRatings)
                .padding(.horizontal, 12)

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(ratings) { rating in
                        RatingRow(rating: rating)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                    }
                }
            }
        }
        .clipped()
        .navigationTitle("mood_tracker")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.orange)
        .animation(.linear, value: ratings.count)
    }

    private func saveTodaysRating(_ value: Int) {
        let rating = Rating(context: context)
        rating.id = UUID()
        rating.date = .now
        rating.value = Int16(value)

        try? context.save()
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
