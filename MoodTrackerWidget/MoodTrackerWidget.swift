//
//  MoodTrackerWidget.swift
//  MoodTrackerWidget
//
//  Created by Mustafa on 1.08.2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> RatingsEntry {
        RatingsEntry(date: .now, ratings: [Rating(date: .now, value: 0)])
    }

    func getSnapshot(in context: Context, completion: @escaping (RatingsEntry) -> ()) {
        let entry = RatingsEntry(date: .now, ratings: Array(Rating.mockRatings.prefix(7)))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [RatingsEntry] = [
            RatingsEntry(
                date: .now,
                ratings: Array(Rating.mockRatings.prefix(7))
            )
        ]
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct RatingsEntry: TimelineEntry {
    let date: Date
    let ratings: [Rating]
}

struct MoodTrackerWidgetEntryView : View {
    var ratingsEntry: RatingsEntry

    var body: some View {
        RatingsChart(ratings: ratingsEntry.ratings)
    }
}

struct MoodTrackerWidget: Widget {
    let kind: String = "MoodTrackerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MoodTrackerWidgetEntryView(ratingsEntry: entry)
        }
        .configurationDisplayName("Weekly Mood Chart")
        .description("This widget shows an overview of last week's moods.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct MoodTrackerWidget_Previews: PreviewProvider {
    static var previews: some View {
        MoodTrackerWidgetEntryView(ratingsEntry: RatingsEntry(date: .now, ratings: Array(Rating.mockRatings.prefix(upTo: 7))))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
