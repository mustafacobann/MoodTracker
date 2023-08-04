//
//  HomeView.swift
//  MoodTracker
//
//  Created by Mustafa on 27.07.2023.
//

import SwiftUI
import WidgetKit
import CoreData

struct HomeView: View {

    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)])
    private var ratings: FetchedResults<Rating>

    @AppStorage("appColor") var appColor: Color = .orange
    @State private var presentingColorPicker = false

    var last7DaysRatings: [Rating] {
        Array(ratings.prefix(7))
    }

    var body: some View {
        VStack(spacing: 12) {
            DayRatingView(ratings: Array(ratings)) { selectedRating in
                PersistenceController.shared.saveTodaysRating(selectedRating)
                WidgetCenter.shared.reloadAllTimelines()
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
                .frame(maxWidth: .infinity)
            }
        }
        .clipped()
        .allowsHitTesting(!presentingColorPicker)
        .navigationTitle("mood_tracker")
        .navigationBarTitleDisplayMode(.inline)
        .background(appColor)
        .animation(.linear, value: ratings.count)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    PersistenceController.shared.removeAllRatings()
                    WidgetCenter.shared.reloadAllTimelines()
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(presentingColorPicker ? .gray : .black)
                }
                .disabled(presentingColorPicker)

                Button(action: { presentingColorPicker.toggle() }) {
                    Image(systemName: presentingColorPicker ? "paintpalette.fill" : "paintpalette")
                        .foregroundColor(.black)
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            if presentingColorPicker {
                ColorSelectionScreen(isBeingPresented: $presentingColorPicker)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
        .animation(.easeInOut, value: presentingColorPicker)
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
