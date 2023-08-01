//
//  DayRatingView.swift
//  MoodTracker
//
//  Created by Mustafa on 27.07.2023.
//

import SwiftUI

struct DayRatingView: View {

    @Binding var ratings: [Rating]
    @State private var selectedRating: Int?

    var isRatingDone: Bool {
        selectedRating != nil
    }

    var body: some View {
        VStack(spacing: 24) {
            TitleView(isRatingDone: isRatingDone)

            if let selectedRating {
                Text("\(selectedRating)")
            } else {
                HStack(spacing: 0) {
                    ForEach(0..<5) { rating in
                        Button {
                            selectedRating = rating + 1
                            let rating = Rating(date: .now, value: rating + 1)
                            ratings.insert(rating, at: 0)
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
            if isRatingDone {
                LottieView(
                    name: "day_rating_animation",
                    loopMode: .playOnce,
                    speed: 2
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
        DayRatingView(ratings: .constant(Rating.mockRatings))
    }
}
