//
//  LandmarkTest.swift
//  LandmarkStorytellerTests
//
//  Created by Nikhil Hore on 22/06/25.
//

import Foundation
import SwiftData
import Testing

@testable import LandmarkStoryteller

struct LandmarkTests {
    @Test func testLandmarkInitialization() {
        let landmark = Landmark(
            name: "Test Landmark",
            latitude: 10.0,
            longitude: 5.5,
            description: "A description"
        )

        #expect(landmark.name == "Test Landmark")
        #expect(landmark.latitude == 10.0)
        #expect(landmark.longitude == 5.5)
        #expect(landmark.description_ == "A description")
        #expect(landmark.foundingDate == nil)
        #expect(landmark.userStories?.isEmpty == true)
    }

    @Test func testLandmarkInitializationWithDate() {
        let date = Date()
        let landmark = Landmark(
            name: "Test Date Landmark",
            latitude: 10.0,
            longitude: 5.5,
            description: "A description",
            foundingDate: date
        )

        #expect(landmark.name == "Test Date Landmark")
        #expect(landmark.foundingDate == date)
    }

    @Test func testLandmarkPersistance() async throws {
        let container = try Test.inMemoryContainer()
        let context = ModelContext(container)
        let landmark = Landmark(
            name: "Persistant Landmark",
            latitude: 10.0,
            longitude: 5.5,
            description: "Should persist"
        )

        context.insert(landmark)
        try context.save()

        let fetchedLandmarks = try context.fetch(FetchDescriptor<Landmark>())
        #expect(fetchedLandmarks.count == 1)
        #expect(fetchedLandmarks.first?.name == "Persistant Landmark")
        #expect(fetchedLandmarks.first?.description_ == "Should persist")
    }

    @Test func testLandmarkUpdate() async throws {
        let container = try Test.inMemoryContainer()
        let context = ModelContext(container)
        let landmark = Landmark(
            name: "Test Landmark",
            latitude: 10.0,
            longitude: 5.5,
            description: "A description"
        )

        context.insert(landmark)
        try context.save()

        landmark.name = "Updated Test Landmark"
        landmark.description_ = "Updated description"
        try context.save()

        let fetchedLandmarks = try context.fetch(FetchDescriptor<Landmark>())
        #expect(fetchedLandmarks.first?.name == "Updated Test Landmark")
        #expect(fetchedLandmarks.first?.longitude == 5.5)
    }

    @Test func testLandmarkDeletion() async throws {
        let container = try Test.inMemoryContainer()
        let context = ModelContext(container)
        let landmarkOne = Landmark(
            name: "Landmark 1",
            latitude: 10.0,
            longitude: 5.5,
            description: "A description"
        )
        let landmarkTwo = Landmark(
            name: "Landmark 2",
            latitude: 10.0,
            longitude: 5.5,
            description: "A description"
        )

        context.insert(landmarkOne)
        context.insert(landmarkTwo)
        try context.save()

        let fetchedLandmarks = try context.fetch(FetchDescriptor<Landmark>())
        #expect(fetchedLandmarks.count == 2)

        context.delete(landmarkOne)

        let newlyFetchedLandmarks = try context.fetch(
            FetchDescriptor<Landmark>()
        )
        #expect(newlyFetchedLandmarks.count == 1)
        #expect(newlyFetchedLandmarks.first?.name == "Landmark 2")
    }
}
