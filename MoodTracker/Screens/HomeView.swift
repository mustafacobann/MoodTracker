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

    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)])
    private var ratings: FetchedResults<Rating>
    
    @AppStorage("appColor") var appColor: Color = .orange
    @State private var presentingColorSelectionSheet = false

    var last7DaysRatings: [Rating] {
        Array(ratings.prefix(7))
    }

    var body: some View {
        VStack(spacing: 12) {
            DayRatingView(ratings: Array(ratings)) { selectedRating in
                saveTodaysRating(selectedRating)
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
        .allowsHitTesting(!presentingColorSelectionSheet)
        .navigationTitle("mood_tracker")
        .navigationBarTitleDisplayMode(.inline)
        .background(appColor)
        .animation(.linear, value: ratings.count)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: removeAllRatings) {
                    Image(systemName: "trash")
                        .foregroundColor(.black)
                }
                Button(action: { presentingColorSelectionSheet.toggle() }) {
                    Image(systemName: presentingColorSelectionSheet ? "paintpalette.fill" : "paintpalette")
                        .foregroundColor(.black)
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            if presentingColorSelectionSheet {
                ColorSelectionScreen()
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
        .animation(.easeInOut, value: presentingColorSelectionSheet)
    }

    // TODO: move CRUD operations to a more appropriate place

    private func saveTodaysRating(_ value: Int) {
        let rating = Rating(context: context)
        rating.id = UUID()
        rating.date = .now
        rating.value = Int16(value)

        try? context.save() // TODO: handle possible errors
    }
    
    private func removeAllRatings() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Rating.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        let result = try? context.execute(batchDeleteRequest) as? NSBatchDeleteResult
        let changes: [AnyHashable: Any] = [
            NSDeletedObjectsKey: result?.result as! [NSManagedObjectID]
        ]
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
        WidgetCenter.shared.reloadAllTimelines()
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
