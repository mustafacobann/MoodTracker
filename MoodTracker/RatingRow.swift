//
//  RatingRow.swift
//  MoodTracker
//
//  Created by Mustafa on 31.07.2023.
//

import SwiftUI

struct RatingRow: View {
    let rating: Rating

    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter.string(from: rating.date)
    }

    var body: some View {
        HStack {
            Text(dateString)
            Spacer()
            Text("\(rating.rating)")
                .foregroundColor(.white)
                .padding()
                .background {
                    Circle()
                        .fill(.black)
                }
        }
        .font(.custom(.varela, size: 20))
        .padding()
        .background(.regularMaterial)
        .cornerRadius(10)
    }
}

struct RatingRow_Previews: PreviewProvider {
    static var previews: some View {
        RatingRow(rating: Rating(date: .now, rating: 5))
    }
}
