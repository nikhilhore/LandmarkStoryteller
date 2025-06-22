//
//  Test.swift
//  LandmarkStoryteller
//
//  Created by Nikhil Hore on 22/06/25.
//

import SwiftData
import Testing

@testable import LandmarkStoryteller

extension Test {
    static func inMemoryContainer() throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        return try ModelContainer(
            for: Landmark.self,
            UserStory.self,
            configurations: config
        )
    }
}
