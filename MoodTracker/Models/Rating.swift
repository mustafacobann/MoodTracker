//
//  Rating.swift
//  MoodTracker
//
//  Created by Mustafa on 31.07.2023.
//

import Foundation

struct Rating: Identifiable {
    let date: Date
    let rating: Int

    var id: Date { date }
}

extension Rating {
    static var mockRatings: [Rating] {
        var ratings: [Rating] = []
        for i in 1..<16 {
            if let date = Calendar.current.date(byAdding: .day, value: -i, to: .now) {
                let rating = Int.random(in: 1...5)
                ratings.append(Rating(date: date, rating: rating))
            }
        }
        return ratings
    }
}
