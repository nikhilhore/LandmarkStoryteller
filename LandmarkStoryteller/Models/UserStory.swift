//
//  UserStory.swift
//  LandmarkStoryteller
//
//  Created by Nikhil Hore on 19/06/25.
//

import Foundation
import SwiftData

@Model
final class UserStory {
    var title: String
    var content: String
    var dateAdded: Date

    // Relationship to Landmark (Inverse relationship will be set up in Landmark.swift)
    var landmark: Landmark?  // A UserStory belongs to one Landmark

    init(
        title: String,
        content: String,
        dateAdded: Date,
        landmark: Landmark? = nil
    ) {
        self.title = title
        self.content = content
        self.dateAdded = dateAdded
        self.landmark = landmark
    }
}
