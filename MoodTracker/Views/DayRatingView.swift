//
//  DayRatingView.swift
//  MoodTracker
//
//  Created by Mustafa on 27.07.2023.
//

import SwiftUI

struct DayRatingView: View {

    let ratings: [Rating]
    var onSelect: (Int) -> Void

    @State private var shouldPlaySelectionAnimation = false

    var selectedRating: Rating? {
        ratings.first { rating in
            guard let date = rating.date else { return false }
            return Calendar.current.isDateInToday(date)
        }
    }

    var isRatingDone: Bool {
        selectedRating != nil
    }

    var body: some View {
        VStack(spacing: 24) {
            TitleView(isRatingDone: isRatingDone)

            if let selectedRating {
                Text("\(selectedRating.value)")
            } else {
                HStack(spacing: 0) {
                    ForEach(0..<5) { rating in
                        Button {
                            onSelect(rating + 1)
                            shouldPlaySelectionAnimation = true
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
        .font(.custom(.varela, size: 34))
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(.thinMaterial)
        .overlay {
            if shouldPlaySelectionAnimation {
                LottieView(
                    name: "day_rating_animation",
                    loopMode: .playOnce,
                    speed: 2,
                    onComplete: { shouldPlaySelectionAnimation = false }
                )
            }
        }
    }
}

private struct TitleView: View {
    let isRatingDone: Bool

    var body: some View {
        Text(isRatingDone ? "todays_rating" : "rate_your_day")
    }
}

struct DayRatingView_Previews: PreviewProvider {
    static var previews: some View {
        DayRatingView(ratings: Rating.previewRatings, onSelect: {_ in})
    }
}
