//
//  Rating+StoreUtils.swift
//  MoodTracker
//
//  Created by Mustafa on 2.08.2023.
//

import Foundation
import CoreData

extension Rating {
    static var previewRatings: [Rating] {
        let ratings = fetchRatings(for: PersistenceController.preview.container.viewContext)
        return Array(ratings)
    }

    static func getLastWeekRatings(for context: NSManagedObjectContext) -> [Rating] {
        let ratings = fetchRatings(for: context)
        return Array(ratings.prefix(7))
    }

    static func fetchRatings(for context: NSManagedObjectContext) -> [Rating] {
        let fetchRequest = Rating.fetchRequest()
        return try! context.fetch(fetchRequest) // TODO: remove forced-unwrapping
    }
}
