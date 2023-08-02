//
//  RatingsChart.swift
//  MoodTracker
//
//  Created by Mustafa on 1.08.2023.
//

import SwiftUI
import Charts

struct RatingsChart: View {

    let ratings: [Rating]

    var body: some View {
        Chart {
            ForEach(ratings) { rating in
                if let date = rating.date {
                    BarMark(
                        x: .value("Date", date, unit: .day),
                        y: .value("Rating", rating.value)
                    )
                }
            }
        }
        .chartYAxis {
            AxisMarks(values: [0, 1, 2, 3, 4, 5])
        }
        .chartXAxis(.hidden)
        .foregroundStyle(.orange)
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .padding()
        .background(.regularMaterial)
        .cornerRadius(10)
    }
}

// FIXME: Fix previews so they can work with CoreData
//struct RatingsChart_Previews: PreviewProvider {
//    static var previews: some View {
//        RatingsChart(ratings: Rating.mockRatings)
//    }
//}
