//
//  DataController.swift
//  MoodTracker
//
//  Created by Mustafa on 2.08.2023.
//

import CoreData
import Foundation

class DataController {
    let container = NSPersistentContainer(name: "MoodTrackerDataModel")

    static var preview: DataController = {
        let previewController = DataController(inMemory: true)

        for i in 0..<10 {
            if let date = Calendar.current.date(byAdding: .day, value: -i, to: .now) {
                let rating = Rating(context: previewController.container.viewContext)
                rating.id = UUID()
                rating.date = date
                rating.value = Int16.random(in: 1...5)
            }
        }

        return previewController
    }()

    init(inMemory: Bool = false) {
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error {
                print("CoreData failed to load: \(error.localizedDescription)")
            }
        }
    }
}
