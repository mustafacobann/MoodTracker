//
//  DayRatingView.swift
//  MoodTracker
//
//  Created by Mustafa on 27.07.2023.
//

import SwiftUI

struct DayRatingView: View {

    @State private var selectedRating: Int?

    var isRatingDone: Bool {
        selectedRating != nil
    }

    var body: some View {
        VStack(spacing: 24) {
            TitleView(isRatingDone: isRatingDone)

            if let selectedRating {
                Text("\(selectedRating)")
                    .font(.title.bold())
            } else {
                HStack(spacing: 0) {
                    ForEach(0..<5) { rating in
                        Button {
                            selectedRating = rating + 1
                        }
                        label: {
                            Image(systemName: "star")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(.thinMaterial)
    }
}

private struct TitleView: View {
    let isRatingDone: Bool

    var body: some View {
        Text(isRatingDone ? "todays_rating" : "rate_your_day")
            .font(.title.bold())
    }
}

struct DayRatingView_Previews: PreviewProvider {
    static var previews: some View {
        DayRatingView()
    }
}
