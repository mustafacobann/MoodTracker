//
//  Rating+PreviewRatings.swift
//  MoodTracker
//
//  Created by Mustafa on 2.08.2023.
//

import Foundation

extension Rating {
    static var previewRatings: [Rating] {
        let context = DataController.preview.container.viewContext
        let fetchRequest = Rating.fetchRequest()
        let ratings = try! context.fetch(fetchRequest) // TODO: remove forced-unwrapping
        return Array(ratings)
    }
}
