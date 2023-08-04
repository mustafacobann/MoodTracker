//
//  PersistenceController.swift
//  MoodTracker
//
//  Created by Mustafa on 2.08.2023.
//

import CoreData
import Foundation

class PersistenceController {

    let container = NSPersistentContainer(name: "MoodTrackerDataModel")

    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let previewController = PersistenceController(inMemory: true)

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
        let url = URL.storeURL(for: .appGroup, dbName: "Ratings")
        let storeDescription = NSPersistentStoreDescription(url: url)
        container.persistentStoreDescriptions = [storeDescription]

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error {
                print("CoreData failed to load: \(error.localizedDescription)")
            }
        }
    }

    func saveTodaysRating(_ value: Int) {
        let context = container.viewContext
        let rating = Rating(context: context)
        rating.id = UUID()
        rating.date = .now
        rating.value = Int16(value)

        do {
            try context.save()
        } catch {
            print("Unable to save the rating value: \(error.localizedDescription)")
        }
    }

    func removeAllRatings() {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Rating.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        let result = try? context.execute(batchDeleteRequest) as? NSBatchDeleteResult
        let changes: [AnyHashable: Any] = [
            NSDeletedObjectsKey: result?.result as! [NSManagedObjectID]
        ]
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
    }
}
