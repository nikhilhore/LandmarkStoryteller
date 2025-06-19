//
//  Landmark.swift
//  LandmarkStoryteller
//
//  Created by Nikhil Hore on 18/06/25.
//

import Foundation
import SwiftData

@Model
final class Landmark {
    var name: String
    var latitude: Double
    var longitude: Double
    var description_: String
    var foundingDate: Date?  // Optional, for historical context

    init(
        name: String,
        latitude: Double,
        longitude: Double,
        description: String,
        foundingDate: Date? = nil
    ) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.description_ = description
        self.foundingDate = foundingDate
    }
}
