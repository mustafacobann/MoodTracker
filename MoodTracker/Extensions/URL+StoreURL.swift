//
//  URL+StoreURL.swift
//  MoodTracker
//
//  Created by Mustafa on 3.08.2023.
//

import Foundation

extension URL {
    static func storeURL(for appGroup: String, dbName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup)
        else { fatalError("Unable to create URL for \(appGroup)") }

        return fileContainer.appendingPathComponent("\(dbName).sqlite")
    }
}
