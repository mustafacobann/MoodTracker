//
//  Color+RawRepresentable.swift
//  MoodTracker
//
//  Created by Mustafa on 4.08.2023.
//

import SwiftUI
import UIKit

extension Color: RawRepresentable {

    public init?(rawValue: String) {
        guard let data = Data(base64Encoded: rawValue)
        else {
            self = .orange
            return
        }

        do {
            let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor ?? .orange
            self = Color(color)
        } catch {
            self = .orange
        }
    }

    public var rawValue: String {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
            return data.base64EncodedString()
        } catch {
            return ""
        }
    }
}
